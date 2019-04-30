Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E016C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B0E20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jFkEp1/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfD3PRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:17:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:37775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3PRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556637462;
        bh=txCz050phlpvCdvRPIpnThNinbh6jWb3GzAgzB4V4u4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jFkEp1/H6t0C57tqMXbydH3SlZxblnLiollftpyraQqkx7L0rrXNU61lbNgADNWnq
         nS8gyZ0xUAgcGUMbP5Uerr+78Fp6a2eZWJehrNaFT+ho15OmqCm0QUf760qCc6O+8d
         YJwx0C/DVObUbV28pbl8j4fGdwjY2d12NL+Ios20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.66]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1hSL551xcH-00BOET; Tue, 30
 Apr 2019 17:17:42 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mfd: ab8500-debugfs: Fix a typo ("deubgfs")
Date:   Tue, 30 Apr 2019 17:17:26 +0200
Message-Id: <20190430151726.7032-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dsJixy6+MJT3hkm5M0MbCX3Ml9BDfe2QiE2R5JwgWbqemoCrFig
 8C10Wvs7BMQji33zLDBMwQvJyJatVREuMzWE5EOITNHxEdwqeLVDFJC6sWwfSqPo3o4y//9
 XSaF1YP0pJqo8Zy8ns+oh8h2JbXDdKC9PqMsCatwmkFER3cBB3IzOXLtPXnd++PKIkyZo+N
 XYDpb+saV0Xu7KHmMXSnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zD4gzko6JBI=:xzyU4z+Vgsqyi7ODLDHoW5
 tueFJvF9M+MRwbbReuAXG8HLFzBASPZs9K9h02joHAMhygJ+BgwAedGn8umdzStC1/hGQkIBj
 sqIzGj1c5qwZcSL9IFj9SBU/8SXgooc26HaDQTrqxk1sGp5aHgawyD5o3cJT3eX69I7rYf57a
 Xs7h8Xs3mQ4CqxOrMoX80rPLsxdqJj1vt3nj4LPzVl5bXjTsCXeWuimpvXrEOTANgQYzieDdP
 BIurK2nRbG36AvMeJEfNGcmyo9tfVBOjuHVRRiGCm/OsnS9soMoueDRjafECbnyuB6sh45Mu5
 8iwZWJ6hBY0NZq9w/nKU3rkdMRYzjv6kX/FgZ0+XC6VVKHXnjgkTUJT8htyb51uCcx7sitoXp
 g9zpEskw4IEVVPyDiu66O7F/bU5D8mjKtR9DzrOy4JdTsStKIxWWlbIMsPcBS/o5XvHhR8N6U
 wdg1hQwayowgn8jspylTXNjgEtZXz+KK38c0FQ7rnfKxHBwBmQjC+gOAInp8t99ZKnhtlfHkG
 r2OR5GwPuunndxZOnRGoZp7awTqLM90BuZX4RCNa8835emNZxuqNi1/EiT57vqI06n7rq2eQp
 f4zs5th8BAecqI8oif4n1nqQIS6KAgODidG9xbCQ+TNFL1131qA5cJxwyJnelht27absbFETj
 vZEF058IbwZCUHcUKT6F/6fLbvL1s5lg/IJcJtwTjQAOmLzryC1mo7KZxFBQ/AwLe7XBCygrG
 PAPqvV2+SvtkcN/JKcUX3yn4i+/ZHBqw8S+64JiQBpPinwwoH+xigOeB0PrZN7DjFdipJ61jA
 bcRWEw9Dv8LfUGyZU0K4TlC2QRmgPwPVxGdAIpXOzK1Eo0YjITVSfXLVL8emzxLiTOO9wWrn6
 HSB0hqZDu7FCdxCzBe8etLGzXw2SUHHO1QcPY/Nks7H3CzhAN0PjAzz6bV5JYOv3XAKFTy00+
 kEeSjY6MtGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"debugfs" was misspelled.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mfd/ab8500-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 8d652b2f9d14..f70d3f6a959b 100644
=2D-- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2587,7 +2587,7 @@ static ssize_t ab8500_unsubscribe_write(struct file =
*file,
 }

 /*
- * - several deubgfs nodes fops
+ * - several debugfs nodes fops
  */

 static const struct file_operations ab8500_bank_fops =3D {
=2D-
2.20.1

