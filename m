Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA769C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 04:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205082196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 04:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="UdAFgGv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfIIEry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 00:47:54 -0400
Received: from mx1.cock.li ([185.10.68.5]:47195 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbfIIEry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 00:47:54 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1568004470; bh=1XEKiW8lRosRp7rTNF760ZAE09CwkhitKBAyDD8ktjc=;
        h=Date:From:To:Subject:From;
        b=UdAFgGv4EHC1UpcVGtnj7odZ2sHmNomsV683a/IZu85PDdqDc9/X25545IknTf/Z/
         gCzbQulJSiKimCajmHveGOhBFjzMqXTUFnlaRACdDe8+SvIJDA+2T9Uf9IZcjMjbVx
         xTMJy3LhhSe/tgG/KA4Hu6xXg/zxENBgetV9N4FxonBKyAfXZRGcY7AA6gcZlYsG5z
         caSB6fo1ruL4xvOOcX9HX0OHFCopH4KnlJsw49Q4CWMytos2KES5HbwCtkFOWye6mD
         H2MWaQtoJPxos5bgF5uVUn2PjWVIsPV/OBpGPUoN2I7tb2/yY/dym3Pv/as7bloSTx
         fbPKj1AkzEjxg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Sep 2019 04:47:48 +0000
From:   gameonlinux@redchan.it
To:     rms@gnu.org, bruce@perens.com, linux-kernel@vger.kernel.org
Subject: Why isn't Grsecurity being sued for its long standing GPL violations?
Message-ID: <f71f6765806f56f5851ddcb9158a6277@redchan.it>
X-Sender: gameonlinux@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, RMS and Bruce Perens;

I noticed that recently Grsecurity's Brad Spengler (who sued you, Bruce, 
for speaking the truth), decided to "Flex" and basically advertise while 
chastising the linux community:

news.ycombinator.com/item?id=20874470


Another poster then pointed out the history of Grsecurity's copyright 
violations (as a derivative work that is restricting redistribution), 
but said he didn't want to say to much, because he didn't want to get 
sued. He referenced your good write-up on the situation: 
perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/

(Which has not changed)

Why isn't Grsecurity being sued for it's copyright violations? They've 
been going on for years now. Clearly their scheme works: it can be shown 
to a court both the attempt to restrict redistribution was tendered (the 
agreement) and that said attempt has been successful.

Also isn't Open Source Security simply an alter-ego of Brad Spengler? 
Him being the only employee? Couldn't the corporate veil be pierced and 
he be found personally liable for any damages?
