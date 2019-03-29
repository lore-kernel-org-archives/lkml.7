Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA962082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="OUX38qa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfC2JWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:22:47 -0400
Received: from chill.innovation.ch ([216.218.245.220]:40466 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfC2JWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:22:47 -0400
Date:   Fri, 29 Mar 2019 02:22:46 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 92A4764013A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553851366;
        bh=IUGqBNuLiPKPnN7hThX8wcpaeI9vvOFmqjUOjmasI8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUX38qa6+pHy1HpYhWMh3CRoaoUAirymqV/woAkgn+NF8Qnuuf8cO+Gi/f3U6Z+/3
         Xm3BPHxxadZ1JbCr9R17bYjqDxLBYtVV9bXMXMqnbrBAhSYjWhtGZ96M6ImCqJhBOa
         CxkIUzM7aw//cpTQiuuNPaAlF8mOTvuK+Q14Ls9EtpUG6iHB3NzKSbJghrBhg66zaU
         9B3RDGQ/BaR9u9gJBwR1B8/uT1F+0/YAlx2nzI4IWVpN9JDMw/NlCe4XduB1Oz22JZ
         Jth3x/VMUg6AbqjAG6AwzN4YLFkxXE1Ul+BhwUlYOy5sQRRrm2jozXpZVHqO+yHnQ4
         Z4bBswFVwbgtQ==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: Re: [PATCH v3 1/4] drm/bridge: sil_sii8620: depend on INPUT
 instead of selecting it.
Message-ID: <20190329092246.GA7306@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <CGME20190327014824epcas2p1f79a41c58f76150f7324169805f506f0@epcas2p1.samsung.com>
 <20190327014807.7472-2-ronald@innovation.ch>
 <9fd8af5b-20ed-5dca-7d5c-98f2926b9b0c@samsung.com>
 <20190328000743.GB24753@innovation.ch>
 <35bf8a61-b84c-3aae-00de-14637d37547b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <35bf8a61-b84c-3aae-00de-14637d37547b@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 28, 2019 at 12:48:39PM +0100, Andrzej Hajda wrote:
> On 28.03.2019 01:07, Life is hard, and then you die wrote:
> >
> > On Wed, Mar 27, 2019 at 03:13:37PM +0100, Andrzej Hajda wrote:
> >> +cc: dri-devel
[snip]
> > It seems your mail client doesn't like me :-) I got neither of your
> > responses. Sorry, I should've checked the archives when I didn't hear
> > anything. In any case thank you for your review, and I will update
> > that patch and send out a new version shortly.
> 
> I see where is the problem: Your mail client (mutt I suppose) sets
> Mail-Followup-To header to all recipients (To and Cc) without the
> sender. And my client (thunderbird) after pressing "Reply-All" checks
> for Mail-Followup-To field, if present it uses only it to set
> recipients, so in your case it does not response to the original author.
> 
> I do not know which mail client works incorrectly in this case, but for
> sure it is not what we want :)
> 
> I do not know how to solve the issue in thunderbird, maybe mutt is more
> configurable?

Thanks for debugging this! I'm sorry, but it looks like this was an
error on my part. So for anybody else using mutt: by default, mutt
will add a Mail-Followup-To header without your own address when
sending mail to any lists you are subscribed to, as defined by the
'subscribe' command (to avoid receiving replies in duplicate, i.e.
once via to/cc and once via the list). Unfortunately I was using a
regex there that included all freedesktop.org lists, not just ones I'm
actually subscribed to, and hence it thought I was subscribed
dri-devel too, leading to the this screwup.

Apologies for this - I guess even after more than 2 decades of mutt
and mailing lists I still manage to not know all its ins and outs.
But it should be fixed now.


  Cheers,

  Ronald

