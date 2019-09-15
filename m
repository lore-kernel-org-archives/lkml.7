Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA2C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2756421479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="kxBZHa97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfIOTRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:17:17 -0400
Received: from mx1.cock.li ([185.10.68.5]:59461 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbfIOTRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:17:16 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1568575033; bh=1XEKiW8lRosRp7rTNF760ZAE09CwkhitKBAyDD8ktjc=;
        h=Date:From:To:Subject:From;
        b=kxBZHa97pOxlB/ZmlF1pUj+PLVlHibCe4HLSofW3ZPw6p3adSjqXJt2Lp10bQHS73
         HuM1+qAfNIxfmikPg35z7wlrgMH1xCBxpKx1c7y7KfVy5lj15oJiDui9BPK3/F3fsM
         ORR7DhUF6kkxbHcHL8vHWGPdZULJGQh9LPz7Tly+vwWvLSOIPwb790pKynq2VWSBZr
         6CNDMjnkTakYyejq+vfyM4WRg5IEAKxPO2A9o31UG/PRqTKR7bBSGt/umsczAQ0Pkh
         Nfg5Rw1mwDyzu16g+0T9ZqNjm/houmM08bNdoU1Ls4Yqz5G35G2cmBrwjTCrHjf9aE
         iB9mLoZSyDDIw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 15 Sep 2019 19:17:12 +0000
From:   gameonlinux@redchan.it
To:     rms@gnu.org, bruce@perens.com, linux-kernel@vger.kernel.org
Subject: Why isn't Grsecurity being sued for its long standing GPL violations?
Message-ID: <dd488b8e0b257b01d460c9017780b486@redchan.it>
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
