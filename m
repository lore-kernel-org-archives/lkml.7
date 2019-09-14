Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C1A20828
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 23:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfINXkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 19:40:24 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:50460 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfINXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 19:40:24 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Sep 2019 19:40:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 08D131CA64;
        Sun, 15 Sep 2019 01:32:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J-KoI0jHpXVu; Sun, 15 Sep 2019 01:32:34 +0200 (CEST)
Received: from function.home (unknown [IPv6:2a01:cb19:979:800:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 664361CA47;
        Sun, 15 Sep 2019 01:32:34 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.92.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1i9HWr-0001im-EC; Sun, 15 Sep 2019 01:32:33 +0200
Date:   Sun, 15 Sep 2019 01:32:33 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>
Cc:     Gregory Nowak <greg@gregn.net>, devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Covici <covici@ccs.covici.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190914233233.lvlxd3p4josiir7w@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." <speakup@linux-speakup.org>,
        Gregory Nowak <greg@gregn.net>, devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Covici <covici@ccs.covici.com>
References: <20190712092319.wmke4i7zqzr26tly@function>
 <20190713004623.GA9159@gregn.net>
 <20190725035352.GA7717@gregn.net>
 <875znqhia0.fsf@cmbmachine.messageid.invalid>
 <m3sgqucs1x.wl-covici@ccs.covici.com>
 <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
 <20190821222209.GA4577@gregn.net>
 <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
 <20190909025429.GA4144@gregn.net>
 <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Okash Khawaja, le sam. 14 sept. 2019 22:08:35 +0100, a ecrit:
> 2. We are still missing descriptions for i18n/ directory. I have added
> filenames below. can someone can add description please:

There are some descriptions in the "14.1.  Files Under the i18n
Subdirectory" section of spkguide.txt

Samuel
