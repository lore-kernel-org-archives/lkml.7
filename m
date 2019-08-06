Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3701C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEEA20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ONK/xW7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfHFQBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:01:36 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com ([77.238.176.99]:40338
        "EHLO sonic301-22.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728756AbfHFQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565107293; bh=jNtS0d89ehc8+myqG69x2etAyV2BlmomuBfFcocdu8E=; h=Subject:References:To:From:Date:In-Reply-To:From:Subject; b=ONK/xW7Wgn26IG+hbCQhXxCWVPFMTcR77glO/lkXIjZ3IGp5A4Qd4CKKYOEZKgsnNFHd8VgoWOCr4tMT/L6Zp56DYExyEBNq/1tHu3hLUjvR+ebnsdnzYK+7vs8GZdoJiS9hNdfcDH6Ca+aVddONl4/gjTohS/rmPa8K1mgNEOCo2ffWZ0zv0Cr5BSfSvyA1QMJ27Wdg0bxNTUTuOYjZfYKjuk9Gttoo8jcv90pstB2zXAYjJ/DU5f8QSBp5wKbtsHlL5IRlAlx4eNOR4rX6ICOeqYwsna5eyK3C76nCxLQ0uxdLE5iMFgeUPg3RAvHgfRFk5Swx+4qRlCr+RZFpmA==
X-YMail-OSG: lGQI5lkVM1l2tx9.7.EEFrPTCqvLSAG9CCuz4UCM3cVEVXYBZtjQfttIhp6wu_C
 C5YTUNLZgDZtE77vU5ombxXUex_pOBsxVkWlzGT3s5r4C_BhS9q6ITt2du4aQ4a7.ruRHAATdLlw
 wn1dVzDzB.44Svq9aCPiX8VUFzuvoM690jPXYRizwO6fW5etN7Jh4jN6BVqU__YQwEISHS0sj9oN
 MSoIZDGUlSPV.uc4prdhNpHDhHRf3Asa58Av.uMwtkiMuJ1vAz2L6TKDcrf0U5CuDA23YwBLSPsT
 czkOKSTF9jGIE6ejYhB68W13NY2.94SlyMZM89ZddT122ZaWs7HUo5pIpak1BzUw23tRzypiluVT
 KZtsRze8rfU5_jInJvBWfpg2IYu32i0HuD6HKlAJwuGezZY9pIx2KXSHpyHd7i46Tr7uVe_WJeAc
 kIzY1UWxtY0p3m5CUQPV.uShU7xzcK3kQNpwn2LhAxwMYsW_9O9bmOQxqK8oLzezvr4bbBiAQ1Ib
 vH4qH2JL9PcC3Jc78Dvvyk7lQkIku3eLScFTR5zVRCM77itjhIq8_xW5uG744u.xugVrO3esW2u_
 DAtr3w6L1yaMJmcName5YVNug5mHg2AB9ExEysNc5jGgB5q6inqw.oESAMpA01jt.hX.B0_XhdKo
 m_93XYCUTN.WFLZCRpwRjHthAOCMf9feyyMx3iWeJiR43baZ1MIZixxwDy3FndJWv1iu2fOa93rD
 4dyo0013yPSpEK0vYlcZxkLPURZZhELp3RSpetQg1ld5vYjipbhUIEHNDcaZ7DQyBy7PdNA1C.b8
 GSPAjIhZO_QkcPXarZX57NwV0kuSWBSSkjrgfaM0DreZCOyH9pyMI3CQQJCgELZkd7W9sRd_6_QM
 mOTjF6SMdo_jhpoEVIJg048qkUGI36.g8ZdVWAC4IO8pMZM2k.9pn9VR0WD69Xm5KAchTumN_X2U
 5SmtTEIQaryM5ijum9n34jBVCXrojWi.HnmGrk0wdJiiWkDsviJlp2x3KIBmfju1neN9yTcY_Tny
 7w4q6NbOxRUP4SAKomum9XPVoJKKEHn4WJHwPr64DiCtrL4br06WgtcUYoY6BoDYaP7vhx9acZq0
 8syI_HE3ROKXkFwN69YWuJYaEFEy7LqUXdPpjwRgOzZfFxMerXqmlDmhKRHyIbIh_bdsFzUHUlWC
 a46TAto5PXg7FnQjKvLaPMyekRaveqx9LXRk9CdDM6P6p0tdJ2WNNZdfDDHBVvMOYE2gp..MIcrQ
 aUg1IyGYTmRWIyQK5tZ0c.dCekHWmQYvdrEQ4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Tue, 6 Aug 2019 16:01:33 +0000
Received: by smtp419.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ae0dec42be37c37928217c90a715bcf1;
          Tue, 06 Aug 2019 16:01:30 +0000 (UTC)
Subject: [EOAN] [PATCH]: SRU for regression bug: 1839154
References: <784f011f-99bb-1bf8-04e9-8c15990ebcb8@debian.org>
To:     linux-kernel@vger.kernel.org
From:   Gianfranco Costamagna <locutusofborg@debian.org>
Openpgp: preference=signencrypt
Autocrypt: addr=locutusofborg@debian.org; prefer-encrypt=mutual; keydata=
 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
 Q5L9/98u3iU=
X-Forwarded-Message-Id: <784f011f-99bb-1bf8-04e9-8c15990ebcb8@debian.org>
Message-ID: <91a04206-e9f4-437d-4b8b-4fda6b9c6002@debian.org>
Date:   Tue, 6 Aug 2019 18:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <784f011f-99bb-1bf8-04e9-8c15990ebcb8@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
there is a serious regression in the 5.2 kernel, already fixed in 5.3-rc2 with an ongoing request of a stable backport:


https://www.spinics.net/lists/netdev/msg590128.html

bug:
https://github.com/torvalds/linux/commit/5142967ab524eb8e5c1f6122e46e2df81bae178b

fix:
https://github.com/torvalds/linux/commit/f41828ee10b36644bb2b2bfa9dd1d02f55aa0516

please apply asap,
this is regressing firewalld testsuite, but the bug is clearly in the kernel itself!


>From f41828ee10b36644bb2b2bfa9dd1d02f55aa0516 Mon Sep 17 00:00:00 2001
From: Christian Hesse <mail@eworm.de>
Date: Thu, 11 Jul 2019 01:31:12 +0200
Subject: [PATCH] netfilter: nf_tables: fix module autoload for redir

Fix expression for autoloading.

Fixes: 5142967ab524 ("netfilter: nf_tables: fix module autoload with inet family")
Signed-off-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_redir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 8487eeff5c0ec..43eeb1f609f13 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -291,4 +291,4 @@ module_exit(nft_redir_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arturo Borrero Gonzalez <arturo@debian.org>");
-MODULE_ALIAS_NFT_EXPR("nat");
+MODULE_ALIAS_NFT_EXPR("redir");
