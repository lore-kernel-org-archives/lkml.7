Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1075C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711B720665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798184;
	bh=mB5qEYVwwmL6p2E8jYpUPaPal0RhjmPcudajxG+tanU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=apoy+DUUEHtBE1QiIJnrJsGRBgeLz6QQoCzuQ4xylx+62/ea1Qy3GwfYt9W+Vnueo
	 HGVKJZ2HOIndAUdsr1M8E8sAYLdt0VRDFHhp5jcM6f0x63AiHZz+V3zed6NeW3l1yv
	 z9lsmEUU1PAzoWJhr8aYYITWNe9vF1VHHIF+OWEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfGVMW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:22:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbfGVMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4wnoQnjXvnfh9OuN8zDIKomjeOlWzLxv+ayQyClMX1Y=; b=C49o/KLa+cBx
        z9v6ErUOQkKoAXf7+/wQSZeiJAc6RR70z6iypfbsWyScVddB/Qh7fZPu3kOx0goMiU1CfOxCDgpEQ
        ogC8dkhjglMUjfxQl84RgiC4PKpfG2w1zKqCGkmkN78xY7DB/8tDmd3Jna4phltvYsIumogdw9Wfk
        f6spc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKU-0007dj-Gq; Mon, 22 Jul 2019 12:22:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DB22327416CB; Mon, 22 Jul 2019 13:22:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: use __u32 instead of uint32_t in uapi headers" to the asoc tree
In-Reply-To: <20190721142308.30306-1-yamada.masahiro@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122209.DB22327416CB@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: use __u32 instead of uint32_t in uapi headers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 62ec3d13601bd626ca7a0edef6d45dbb753d94e8 Mon Sep 17 00:00:00 2001
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 21 Jul 2019 23:23:08 +0900
Subject: [PATCH] ASoC: SOF: use __u32 instead of uint32_t in uapi headers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
make sure they can be included from user-space.

Currently, header.h and fw.h are excluded from the test coverage.
To make them join the compile-test, we need to fix the build errors
attached below.

For a case like this, we decided to use __u{8,16,32,64} variable types
in this discussion:

  https://lkml.org/lkml/2019/6/5/18

Build log:

  CC      usr/include/sound/sof/header.h.s
  CC      usr/include/sound/sof/fw.h.s
In file included from <command-line>:32:0:
./usr/include/sound/sof/header.h:19:2: error: unknown type name ‘uint32_t’
  uint32_t magic;  /**< 'S', 'O', 'F', '\0' */
  ^~~~~~~~
./usr/include/sound/sof/header.h:20:2: error: unknown type name ‘uint32_t’
  uint32_t type;  /**< component specific type */
  ^~~~~~~~
./usr/include/sound/sof/header.h:21:2: error: unknown type name ‘uint32_t’
  uint32_t size;  /**< size in bytes of data excl. this struct */
  ^~~~~~~~
./usr/include/sound/sof/header.h:22:2: error: unknown type name ‘uint32_t’
  uint32_t abi;  /**< SOF ABI version */
  ^~~~~~~~
./usr/include/sound/sof/header.h:23:2: error: unknown type name ‘uint32_t’
  uint32_t reserved[4]; /**< reserved for future use */
  ^~~~~~~~
./usr/include/sound/sof/header.h:24:2: error: unknown type name ‘uint32_t’
  uint32_t data[0]; /**< Component data - opaque to core */
  ^~~~~~~~
In file included from <command-line>:32:0:
./usr/include/sound/sof/fw.h:49:2: error: unknown type name ‘uint32_t’
  uint32_t size;  /* bytes minus this header */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:50:2: error: unknown type name ‘uint32_t’
  uint32_t offset; /* offset from base */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:64:2: error: unknown type name ‘uint32_t’
  uint32_t size;  /* bytes minus this header */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:65:2: error: unknown type name ‘uint32_t’
  uint32_t num_blocks; /* number of blocks */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:73:2: error: unknown type name ‘uint32_t’
  uint32_t file_size; /* size of file minus this header */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:74:2: error: unknown type name ‘uint32_t’
  uint32_t num_modules; /* number of modules */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:75:2: error: unknown type name ‘uint32_t’
  uint32_t abi;  /* version of header format */
  ^~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Link: https://lore.kernel.org/r/20190721142308.30306-1-yamada.masahiro@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/sof/fw.h     | 16 +++++++++-------
 include/uapi/sound/sof/header.h | 14 ++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/uapi/sound/sof/fw.h b/include/uapi/sound/sof/fw.h
index 1afca973eb09..e9f697467a86 100644
--- a/include/uapi/sound/sof/fw.h
+++ b/include/uapi/sound/sof/fw.h
@@ -13,6 +13,8 @@
 #ifndef __INCLUDE_UAPI_SOF_FW_H__
 #define __INCLUDE_UAPI_SOF_FW_H__
 
+#include <linux/types.h>
+
 #define SND_SOF_FW_SIG_SIZE	4
 #define SND_SOF_FW_ABI		1
 #define SND_SOF_FW_SIG		"Reef"
@@ -46,8 +48,8 @@ enum snd_sof_fw_blk_type {
 
 struct snd_sof_blk_hdr {
 	enum snd_sof_fw_blk_type type;
-	uint32_t size;		/* bytes minus this header */
-	uint32_t offset;	/* offset from base */
+	__u32 size;		/* bytes minus this header */
+	__u32 offset;		/* offset from base */
 } __packed;
 
 /*
@@ -61,8 +63,8 @@ enum snd_sof_fw_mod_type {
 
 struct snd_sof_mod_hdr {
 	enum snd_sof_fw_mod_type type;
-	uint32_t size;		/* bytes minus this header */
-	uint32_t num_blocks;	/* number of blocks */
+	__u32 size;		/* bytes minus this header */
+	__u32 num_blocks;	/* number of blocks */
 } __packed;
 
 /*
@@ -70,9 +72,9 @@ struct snd_sof_mod_hdr {
  */
 struct snd_sof_fw_header {
 	unsigned char sig[SND_SOF_FW_SIG_SIZE]; /* "Reef" */
-	uint32_t file_size;	/* size of file minus this header */
-	uint32_t num_modules;	/* number of modules */
-	uint32_t abi;		/* version of header format */
+	__u32 file_size;	/* size of file minus this header */
+	__u32 num_modules;	/* number of modules */
+	__u32 abi;		/* version of header format */
 } __packed;
 
 #endif
diff --git a/include/uapi/sound/sof/header.h b/include/uapi/sound/sof/header.h
index 7868990b0d6f..5f4518e7a972 100644
--- a/include/uapi/sound/sof/header.h
+++ b/include/uapi/sound/sof/header.h
@@ -9,6 +9,8 @@
 #ifndef __INCLUDE_UAPI_SOUND_SOF_USER_HEADER_H__
 #define __INCLUDE_UAPI_SOUND_SOF_USER_HEADER_H__
 
+#include <linux/types.h>
+
 /*
  * Header for all non IPC ABI data.
  *
@@ -16,12 +18,12 @@
  * Used by any bespoke component data structures or binary blobs.
  */
 struct sof_abi_hdr {
-	uint32_t magic;		/**< 'S', 'O', 'F', '\0' */
-	uint32_t type;		/**< component specific type */
-	uint32_t size;		/**< size in bytes of data excl. this struct */
-	uint32_t abi;		/**< SOF ABI version */
-	uint32_t reserved[4];	/**< reserved for future use */
-	uint32_t data[0];	/**< Component data - opaque to core */
+	__u32 magic;		/**< 'S', 'O', 'F', '\0' */
+	__u32 type;		/**< component specific type */
+	__u32 size;		/**< size in bytes of data excl. this struct */
+	__u32 abi;		/**< SOF ABI version */
+	__u32 reserved[4];	/**< reserved for future use */
+	__u32 data[0];		/**< Component data - opaque to core */
 }  __packed;
 
 #endif
-- 
2.20.1

