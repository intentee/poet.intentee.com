fn template(context, props, content) {
  let asset_path = context.assets.file(props.src);

  component {
    <figure>
      <a
        href={asset_path}
        target="_blank"
      ><img alt={props.alt} src={asset_path} /></a>
      <figcaption>{props.alt}</figcaption>
    </figure>
  }
}
