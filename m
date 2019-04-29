Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73812C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B92B2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="BTwgcF7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfD2Vpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:45:44 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:33808 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbfD2Vpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:45:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 25D884A3;
        Mon, 29 Apr 2019 23:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1556574340; x=1558388741; bh=FkmmNzOhZAiBzAGvga+
        1Vd0vaNR7piDEbAc1VZkwiiU=; b=BTwgcF7DaVhW4uhAH/kU+jE1Tfat1Bsh5NU
        hAP/AvbxRpJKWwppoQ5jHwhILZOLtYZN6jq0StiBx91Dt5fHeCSgppzbiLlRBHNf
        37faZJOkTQgL6YR0+QKT91lVmtgYO93kiA7VgFKfLRwdB95wNFzjVo4a0n16dHIK
        Zfa3ZTC28dRXJbU3vv3UKveIW1EzEqJb8XcUv3VdNKjqj9E2tqhUYyBGbhJQeVXl
        hz3bFoDhCMV9PhIUaVZAd1wX/1Jax0NKaiTABsYCQPmxMCsppYTtWB0thWir7jBI
        /0q9+Pz4Pl55xfvi8jwH+Sl2ikue6Uid1zGLMViXmWF7/A+/tdVwv6gn6Qt7Q48n
        p4e2k95zd2msoT4JTJ+JLRyGz4M5ex7/DXqxsiQpdXaoGmCXx1NLTxLjOkACF7mA
        4929iJCS0xmhaxDGbYEnrcwLs4e4joVNYtvc+Lch5Jd+wotqWjZaqyKmBnbK3/5g
        fpwzHL4EHMGBLKI8txYQZalDYh8TitjrrjnXhv2XbvpOpG2bAR8a8c+a4SJ6LsTt
        5FtVQSgxxmzLhSV2N6oBFwnNFrWE12B2sJUdS1k/dhwX1/hczSM3UhuHEmxtAX5v
        8CAxlxkWvhDmhRomIts1CXbKqm9w5nEry3QMckTg3Nqiy+rAVP16+u2Ou6hXtYRr
        UqVqDjdk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aKTMrz2PH84d; Mon, 29 Apr 2019 23:45:40 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id D985C1F1;
        Mon, 29 Apr 2019 23:45:39 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 8C2DB517;
        Mon, 29 Apr 2019 23:45:39 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: fix typo in PGP guide
Date:   Mon, 29 Apr 2019 23:45:14 +0200
Message-Id: <20190429214514.25625-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the GPG guide for maintainers

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/maintainer-pgp-guide.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index aff9b1a4d77b..4bab7464ff8c 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -943,7 +943,7 @@ have on your keyring::
 
 Next, open the `PGP pathfinder`_. In the "From" field, paste the key
 fingerprint of Linus Torvalds from the output above. In the "To" field,
-paste they key-id you found via ``gpg --search`` of the unknown key, and
+paste the key-id you found via ``gpg --search`` of the unknown key, and
 check the results:
 
 - `Finding paths to Linus`_
-- 
2.20.1

