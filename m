Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282C233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="WxeWpafP";
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="WxeWpafP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfHVTLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:11:21 -0400
Received: from fourecks.uuid.uk ([147.135.211.183]:41296 "EHLO
        fourecks.uuid.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391583AbfHVTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:19 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 15:11:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:Subject:From:To;
        bh=OAlRsLcjaZiy9hKBh4Dzu9JGtVQv9+nMxxcC4DwGtVc=; b=WxeWpafPxyTD/Yx7uU7/sVPyES
        vLEuatVHlSYt+cCWxhfhhN23j7A70drAHiB+TXncxIcFyuEa3u36xtIBsDozkVP28e4ED8s7s7P1+
        F7URB9xp+J/Nh6kLGS4obyb/hB+wVfuR2FGaGFpbMwmy+0lauGf0+aewEkTfc6+j2ObVrFy8SPoxD
        PazRuOaSxNbpy3KyV87drDdEXHuiB1r8GVDtfGj9zakVnrGkm5o/1nghdoGPgfY/aP3k/5RONooj+
        k1csNBgvOoM/J+UqALUCu1lQ/wmDSp/nI9P2gHeHwXDrvpiRwnkkPzERJsL7XpyINscj50hqEC1lr
        iwusU9IQ==;
Received: by fourecks.uuid.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1i0sLd-0002LD-Cb; Thu, 22 Aug 2019 20:02:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:Subject:From:To;
        bh=OAlRsLcjaZiy9hKBh4Dzu9JGtVQv9+nMxxcC4DwGtVc=; b=WxeWpafPxyTD/Yx7uU7/sVPyES
        vLEuatVHlSYt+cCWxhfhhN23j7A70drAHiB+TXncxIcFyuEa3u36xtIBsDozkVP28e4ED8s7s7P1+
        F7URB9xp+J/Nh6kLGS4obyb/hB+wVfuR2FGaGFpbMwmy+0lauGf0+aewEkTfc6+j2ObVrFy8SPoxD
        PazRuOaSxNbpy3KyV87drDdEXHuiB1r8GVDtfGj9zakVnrGkm5o/1nghdoGPgfY/aP3k/5RONooj+
        k1csNBgvOoM/J+UqALUCu1lQ/wmDSp/nI9P2gHeHwXDrvpiRwnkkPzERJsL7XpyINscj50hqEC1lr
        iwusU9IQ==;
Received: by tsort.uuid.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1i0sLN-0006jX-Ag; Thu, 22 Aug 2019 20:02:10 +0100
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Simon Arlott <simon@octiron.net>
Subject: [PATCH] mailmap: Add Simon Arlott (replacement for expired email
 address)
Cc:     trivial@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <ab8c62db-b207-9aa1-e99c-16f9eb4152df@simon.arlott.org.uk>
Date:   Thu, 22 Aug 2019 20:01:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add replacement email address for the one on my expired domain.

Signed-off-by: Simon Arlott <simon@octiron.net>
---
I'd prefer not to be in this "list of email addresses to spam" but it
appears to be the only way to stop people searching for other addresses
to misuse after I had to let my domain expire:

"Where, as of the withdrawal date and as a result of the withdrawal of
the United Kingdom, a holder of a domain name does no longer fulfil the
general eligibility criteria pursuant to Article 4(2)(b) of Regulation
(EC) 733/2002, the Registry for .eu will be entitled to revoke such
domain name on its own initiative and without submitting the dispute to
any extrajudicial settlement of conflicts in accordance with point (b)
of Article 20, first subparagraph, of Commission Regulation (EC) No
874/2004."

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index acba1a6163f1..468e328ee572 100644
--- a/.mailmap
+++ b/.mailmap
@@ -214,6 +214,7 @@ Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
 Shuah Khan <shuah@kernel.org> <shuahkh@osg.samsung.com>
 Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
+Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
 Simon Kelley <simon@thekelleys.org.uk>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <shemminger@osdl.org>
-- 
2.17.1

-- 
Simon Arlott
