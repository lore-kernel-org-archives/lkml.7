Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706D0C742D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B8820863
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gregn.net header.i=@gregn.net header.b="VgxNgp8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfGMAxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:53:05 -0400
Received: from vserver.gregn.net ([174.136.110.154]:46576 "EHLO
        vserver.gregn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfGMAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:53:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 20:53:05 EDT
Received: from vbox.gregn.net (unknown [IPv6:2001:470:d:6c5:1c66:a9af:c229:a6c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 4CF4A29AF;
        Fri, 12 Jul 2019 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1562978903; bh=W1cDxqPtwaYUSqAPJJNEkGyGvwtv7TWpa9b1CyQ5Qfo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VgxNgp8TpKiCwy+Rt52B2M5V5Ze5WsvyewxpEBKeMWWH5AstiAXDgsfwHG9Ey+HyV
         gJvLwz3Nr4SHm4iLaUhsvHaIUP5dtWPcERiKA87dapqVX8AunH2Yr9jvo2FFj2rNz/
         JTqbJAeSW1OrUNMLRw/xJCWTmscpegDuCQviArk8ka26qYmPXICtA/G38TQ3NzgNXj
         iEY+b1itQ3ztZ0WT5gP0ZwfH9s/IzI1fDqd02KjjWFxS6QyecBHkCWe8qPqKmxQp9p
         c0Oh8w+iRnpMah3PKuS/DH6ubSs9bcT6UnzbuDub8Sdbyalqeik0ZlMy19yE4zm4nc
         UfOTw2hZt6fqA==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1hm6BD-0002cY-QK; Fri, 12 Jul 2019 17:46:23 -0700
Date:   Fri, 12 Jul 2019 17:46:23 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190713004623.GA9159@gregn.net>
References: <20190315130035.6a8f16e9@narunkot>
 <20190316031831.GA2499@kroah.com>
 <20190706200857.22918345@narunkot>
 <20190707065710.GA5560@kroah.com>
 <20190712083819.GA8862@kroah.com>
 <20190712092319.wmke4i7zqzr26tly@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712092319.wmke4i7zqzr26tly@function>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.100.3 at vserver
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:23:19AM +0200, Samuel Thibault wrote:
> Hello,
> 
> To readers of the linux-speakup: could you help on this so we can get
> Speakup in mainline?  Neither Okash or I completely know what user
> consequences the files in /sys/accessibility/speakup/ have, so could
> people give brief explanations for each file (something like 3-6 lines
> of explanation)?

I have a recollection of documenting most of this on the speakup list
in response to a similar query a number of years ago. Unfortunately,
the speakup mailing list archives aren't easily searchable, and I
don't have a local copy of that mail.

Kirk, doing grep with a few of the file names in
/sys/accessibility/speakup against the list's mbox file archive should
find that message if it's in fact there. If you can please find it,
and post the date when it was sent, we can provide a URL to that
thread as a starting point. If my recollection is wrong, and such a
message isn't in the archives, I'll write up what I know about.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
