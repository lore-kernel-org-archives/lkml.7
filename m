Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CBEC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDBB2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gregn.net header.i=@gregn.net header.b="nV+cWVQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfHUWWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:22:12 -0400
Received: from vserver.gregn.net ([174.136.110.154]:43724 "EHLO
        vserver.gregn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731023AbfHUWWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:22:12 -0400
Received: from vbox.gregn.net (unknown [IPv6:2001:470:d:6c5:6ccc:a12a:8d2e:4f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 702AE6E2;
        Wed, 21 Aug 2019 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1566426131; bh=144Ohs+i0Q11OCQeediSILhYP4LPx0bUH56q3gXaKrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV+cWVQmXrejg6AE9X7t2ZjZb7Qj1BYYfkz6+ujg5sznVDYfC7KcswQg2O19hSbrM
         0kogOgMWe17p/voMqsZUMogjFXdls+VZWlH+RYfup/dOC1WlAgJ/XxlC7gA7rb02R3
         b4gNMLF+u8bej+jToajN7LDtLlUPSWa/d6u6+q5KuqAkecHVztniLeMhnm/lCspvlF
         7Xutc7YMcQnRBqrfbmdVMpb9wq0tH0x9fs+x9IwIUcGYvmqn0co8mp5COh5obE/CHP
         XnbRtJTwZRRyyedV412XyK+GFi7ceK5nT2wuaqkyYm2mGIV4JoPyXbhmSjPTdRmctl
         CG1I9Y50TEnnA==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1i0YzZ-0001Up-I9; Wed, 21 Aug 2019 15:22:09 -0700
Date:   Wed, 21 Aug 2019 15:22:09 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>
Cc:     devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Covici <covici@ccs.covici.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190821222209.GA4577@gregn.net>
References: <20190316031831.GA2499@kroah.com>
 <20190706200857.22918345@narunkot>
 <20190707065710.GA5560@kroah.com>
 <20190712083819.GA8862@kroah.com>
 <20190712092319.wmke4i7zqzr26tly@function>
 <20190713004623.GA9159@gregn.net>
 <20190725035352.GA7717@gregn.net>
 <875znqhia0.fsf@cmbmachine.messageid.invalid>
 <m3sgqucs1x.wl-covici@ccs.covici.com>
 <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.100.3 at vserver
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:39:25AM -0700, Okash Khawaja wrote:
> Hi Greg N,
> 
> Would like to send this as a patch as Greg K-H suggested? If not, I
> can do that with your email in Authored-by: tag?
> 
> Thanks,
> Okash

Hi Okash and all,
feel free to submit the patch with my email in the Authored-by:
tag if that's OK. Thanks, and good luck on your presentation.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
