--------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Text.Pandoc.Extensions
import           Text.Pandoc.Options
import           Text.Pandoc.Highlighting
import           System.FilePath                 ((</>))
--import           Text.Pandoc.SideNote            (usingSideNotes)

--------------------------------------------------------------------------------

syntaxHighlightingStyle :: Style
syntaxHighlightingStyle = pygments

config :: Configuration
config = defaultConfiguration
    { destinationDirectory = "docs"
    }

main :: IO ()
main = do 
    -- Generate css stytling for code highlighting
    let css = styleToCss syntaxHighlightingStyle
    writeFile ("css" </> "syntax.css") css >> putStrLn " Generated css/syntax.css"
    appendFile ("css" </> "syntax.css") "div.sourceCode { padding: 0.75em; }" >> putStrLn " Updated padding for css/syntax.css"
    appendFile ("css" </> "syntax.css") "div.sourceCode { background: #eeeeee; }" >> putStrLn " Updated background color for css/syntax.css"
    appendFile ("css" </> "syntax.css") "div.sourceCode { font-size: 65%; }" >> putStrLn " Updated font size for css/syntax.css"


    hakyllWith config $ do 

            match "Images/*" $ do
                route   idRoute
                compile copyFileCompiler

            match "Fonts/**/*" $ do
                route   idRoute
                compile copyFileCompiler

            match "css/*" $ do
                route   idRoute
                compile compressCssCompiler
         
            match (fromList ["about.rst", "contact.markdown"]) $ do
                route   $ setExtension "html"
                compile $ pandocMathCompiler
                    >>= loadAndApplyTemplate "templates/default.html" defaultContext
                    >>= relativizeUrls

            match "posts/*" $ do
                route $ setExtension "html"
                compile $ pandocMathCompiler
                    >>= loadAndApplyTemplate "templates/post.html"    postCtx
                    >>= loadAndApplyTemplate "templates/default.html" postCtx
                    >>= relativizeUrls

            create ["archive.html"] $ do
                route idRoute
                compile $ do
                    posts <- recentFirst =<< loadAll "posts/*"
                    let archiveCtx =
                            listField "posts" postCtx (return posts) `mappend`
                            constField "title" "Archives"            `mappend`
                            defaultContext

                    makeItem ""
                        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                        >>= relativizeUrls

            match "index.html" $ do
                route idRoute
                compile $ do
                    posts <- recentFirst =<< loadAll "posts/*"
                    let indexCtx =
                            listField "posts" postCtx (return posts) `mappend`
                            constField "title" "Home"                `mappend`
                            defaultContext

                    getResourceBody
                        >>= applyAsTemplate indexCtx
                        >>= loadAndApplyTemplate "templates/default.html" indexCtx
                        >>= relativizeUrls

            match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

--------------------------------------------------------------------------------

pandocMathCompiler :: Compiler (Item String)
pandocMathCompiler =
    let 
    markdownExtensions = 
        [ Ext_markdown_in_html_blocks 
        , Ext_bracketed_spans
        ]
    mathExtensions = 
        [ Ext_tex_math_dollars
        , Ext_tex_math_double_backslash
        , Ext_latex_macros 
        ]
    codeExtensions = 
        [ Ext_fenced_code_blocks
        , Ext_backtick_code_blocks                      
        , Ext_fenced_code_attributes 
        ]
    defaultExtensions = writerExtensions defaultHakyllWriterOptions  
    newExtensions = foldr enableExtension defaultExtensions (markdownExtensions <> (mathExtensions <> codeExtensions))
    writerOptions = 
        defaultHakyllWriterOptions 
        { writerExtensions = newExtensions
        , writerHTMLMathMethod = MathJax ""
        , writerHighlightStyle = Just syntaxHighlightingStyle 
        }
    in pandocCompilerWith defaultHakyllReaderOptions writerOptions





---------------------------------------------------------------------------------

-- This section in between the ----- dashed lines ------ is for Sidenotes!!!!!! --

{-
myPandocCompiler :: Compiler (Item String)
myPandocCompiler =
  pandocCompilerWithTransformM
    defaultHakyllReaderOptions
  --myWriter
  --(
-- --. pygments
-- --. usingSidenotes          -- sidenotes
  --)
---}
----------------------------------------------------------------------------------
 
-- This section is for the automated table of contents geenration using pandoc	
{-
withToc :: WriterOptions
withToc = defaultHakyllWriterOptions
        { writerTableOfContents = True
        , writerTOCDepth = 2
--      , writerTemplate = Just "Table of Contents\n$toc$\n$body$"
--      }      
---}

 
