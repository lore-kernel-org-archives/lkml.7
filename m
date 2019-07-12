Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B3C742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CED2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGLJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:23:27 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:46694 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGLJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:23:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 80491918D;
        Fri, 12 Jul 2019 11:23:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RzIOWer-JWEV; Fri, 12 Jul 2019 11:23:24 +0200 (CEST)
Received: from function (212.99.1.109.rev.sfr.net [109.1.99.212])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id B71A7918A;
        Fri, 12 Jul 2019 11:23:24 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1hlrlv-0007Ty-DQ; Fri, 12 Jul 2019 11:23:19 +0200
Date:   Fri, 12 Jul 2019 11:23:19 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     speakup@linux-speakup.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christopher Brannon <chris@the-brannons.com>
Subject: [HELP REQUESTED from the community] Was: Staging status of speakup
Message-ID: <20190712092319.wmke4i7zqzr26tly@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Okash Khawaja <okash.khawaja@gmail.com>, devel@driverdev.osuosl.org,
        Kirk Reiser <kirk@reisers.ca>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christopher Brannon <chris@the-brannons.com>
References: <20190315130035.6a8f16e9@narunkot>
 <20190316031831.GA2499@kroah.com>
 <20190706200857.22918345@narunkot>
 <20190707065710.GA5560@kroah.com>
 <20190712083819.GA8862@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712083819.GA8862@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

To readers of the linux-speakup: could you help on this so we can get
Speakup in mainline?  Neither Okash or I completely know what user
consequences the files in /sys/accessibility/speakup/ have, so could
people give brief explanations for each file (something like 3-6 lines
of explanation)?

The i18n/ files have been already documented in section 14.1 of the
spkguide.txt, so we do not need help for them.

Thanks!
Samuel

Greg KH, le ven. 12 juil. 2019 10:38:19 +0200, a ecrit:
> Can you make up a patch to create a
> drivers/staging/speakup/sysfs-speakup file with the needed information?
> That way it will be much easier to determine exactly what these sysfs
> files do and my review can be easier, and perhaps not needed at all :)
