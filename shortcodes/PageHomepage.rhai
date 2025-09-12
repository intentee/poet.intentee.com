fn template(context, props, content) {
  context.assets.add("resources/css/page-homepage.css");

  component {
    <LayoutMinimal>
      <div class="homepage">
        <div class="homepage__product-name">
          Poet - Developed by <a href="https://intentee.com">Intentee</a>
        </div>
        <h1 class="homepage__title">
          Make your docs accessible in AI tools
        </h1>
        <div class="homepage__details">
          <div class="homepage__details__section">
            <h2>What is it?</h2>
            <p>
              Poet is a static site generator with LLM SEO features, RAG, and a built-in MCP server.
            </p>
          </div>
          <div class="homepage__details__section">
            <h2>Why?</h2>
            <p>
              According to the
              <a href="https://survey.stackoverflow.co/2025/stack-overflow#participation-and-feedback-so-dev-content">StackOverflow Developer Survey</a>
              most developers prefer both interactive formats and long-form articles when learning new technologies. Why not provide both in one go?
            </p>
          </div>
          <div class="homepage__cta">
            <a href={context.link_to("#static-site-generator-initial-page")} class="homepage__cta__button homepage__cta__button--primary">
              Get Started
            </a>
            <a href={context.link_to("#install")} class="homepage__cta__button">
              Install
            </a>
          </div>
        </div>
      </div>
    </LayoutMinimal>
  }
}
