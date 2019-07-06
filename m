Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427CC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76A320838
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="sEXL8oin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGFVBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 17:01:32 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:54860 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfGFVBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 17:01:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 004D241F;
        Sat,  6 Jul 2019 23:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1562446888; x=1564261289; bh=j/XAKu4NdyGGJP5PTgU
        NXIHyg5E5uWYGvWYRjnL5tWk=; b=sEXL8oincMEawCispLtXidPADNyjp4KZ8jL
        TjSB7xWDpG8vWSvKO/X/i2pew9htn5wH76fJSv/BFn7ooJ6lxNp497woFUk6U1K7
        uvwoUBWUSUvT+rQrQ8Ur5/Fy1pHri7bRK9/XGT9DIjkHPUApsct0g8IfpH4yiur/
        3a3/2U7eEwsO53/Ntp/IP206zJj8golcqvEw5fXpY3Va2ZgbXkA0gm83lP0u/iAh
        /mzAVgcsOUBG3kkUeoEO3xKfROSKmnbV2WY5XZigfBIdqgXQnjMb7IjmhF3wZvoX
        aaDI/JIA2m3LGDdjRJt1rXK8+PH7UEn5P7uYjl28ijG5yNdo7RJ+9nXUHSjqFqwm
        8Xf+AlTwCyfVRyqFoqk3EMZwz/UMsemB1raaQ+dfRW//el3uS8VFzMI9dUOkrbV2
        5iWd8AuZoEU+KQ7Sd6RRi7S0vPe5259h+oSkhuTrHgyM5PO89KGy9VSSOqGDcoTl
        5tZKWN4En4H/L5Gal0w2y+cqmpBHG5TcRkcjy1GtQXg21m19yfECdav7IaSreUI1
        Zfnr4C36+NGemSFotQ+4snwEf68Tp5QLLdBJYFTmcjd1PMyVUaCXnJhjLdnZoFfM
        IeeBJXLxH9atpXy+beyV//eD50FH6FYE/OeIfar+T0z4KQb4HBHNLzdWHlqgP/7K
        uvkxdHQM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cr70al6WbDii; Sat,  6 Jul 2019 23:01:28 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 626A33BC;
        Sat,  6 Jul 2019 23:01:28 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id E4C3AAD7;
        Sat,  6 Jul 2019 23:01:27 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: email-clients miscellaneous fixes
Date:   Sat,  6 Jul 2019 23:01:00 +0200
Message-Id: <20190706210100.26698-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed some style inconsistencies and remove old statement referring to
kmail missing feature (saving email from the view window is possible).

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/email-clients.rst | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 07faa5457bcb..5273d06c8ff6 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -40,7 +40,7 @@ Emailed patches should be in ASCII or UTF-8 encoding only.
 If you configure your email client to send emails with UTF-8 encoding,
 you avoid some possible charset problems.
 
-Email clients should generate and maintain References: or In-Reply-To:
+Email clients should generate and maintain "References:" or "In-Reply-To:"
 headers so that mail threading is not broken.
 
 Copy-and-paste (or cut-and-paste) usually does not work for patches
@@ -89,7 +89,7 @@ Claws Mail (GUI)
 
 Works. Some people use this successfully for patches.
 
-To insert a patch use :menuselection:`Message-->Insert` File (:kbd:`CTRL-I`)
+To insert a patch use :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`)
 or an external editor.
 
 If the inserted patch has to be edited in the Claws composition window
@@ -132,8 +132,8 @@ wrapping.
 At the bottom of your email, put the commonly-used patch delimiter before
 inserting your patch:  three hyphens (``---``).
 
-Then from the :menuselection:`Message` menu item, select insert file and
-choose your patch.
+Then from the :menuselection:`Message` menu item, select
+:menuselection:`insert file` and choose your patch.
 As an added bonus you can customise the message creation toolbar menu
 and put the :menuselection:`insert file` icon there.
 
@@ -149,18 +149,16 @@ patches so do not GPG sign them.  Signing patches that have been inserted
 as inlined text will make them tricky to extract from their 7-bit encoding.
 
 If you absolutely must send patches as attachments instead of inlining
-them as text, right click on the attachment and select properties, and
-highlight :menuselection:`Suggest automatic display` to make the attachment
+them as text, right click on the attachment and select :menuselection:`properties`,
+and highlight :menuselection:`Suggest automatic display` to make the attachment
 inlined to make it more viewable.
 
 When saving patches that are sent as inlined text, select the email that
 contains the patch from the message list pane, right click and select
 :menuselection:`save as`.  You can use the whole email unmodified as a patch
-if it was properly composed.  There is no option currently to save the email
-when you are actually viewing it in its own window -- there has been a request
-filed at kmail's bugzilla and hopefully this will be addressed.  Emails are
-saved as read-write for user only so you will have to chmod them to make them
-group and world readable if you copy them elsewhere.
+if it was properly composed.  Emails are saved as read-write for user only so
+you will have to chmod them to make them group and world readable if you copy
+them elsewhere.
 
 Lotus Notes (GUI)
 *****************
-- 
2.21.0

