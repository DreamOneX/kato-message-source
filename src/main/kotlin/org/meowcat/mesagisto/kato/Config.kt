package org.meowcat.mesagisto.kato

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
@Serializable
data class RootConfig(
  val enable: Boolean = false,
  val channel: String = "your-channel",
  val cipher: CipherConfig = CipherConfig(),
  var idBase: Int = 0,
  val nats: String = "nats://itsusinn.site:4222",
  val template: TemplateConfig = TemplateConfig()
)
@Serializable
data class CipherConfig(
  val enable: Boolean = true,
  val key: String = "your-key",
  @SerialName("refuse-plain")
  val refusePlain: Boolean = true
)
@Serializable
data class TemplateConfig(
  val message: String = "§7<{{sender}}> {{content}}"
)
