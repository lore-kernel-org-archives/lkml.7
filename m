Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F21C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79915206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gregn.net header.i=@gregn.net header.b="SHX4qgNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391335AbfIPUVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:21:51 -0400
Received: from vserver.gregn.net ([174.136.110.154]:44082 "EHLO
        vserver.gregn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIPUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:21:51 -0400
Received: from vbox.gregn.net (unknown [IPv6:2001:470:d:6c5:2128:c4cd:3fb7:de37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 11CB5475;
        Mon, 16 Sep 2019 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1568665348; bh=Z5YoCFCZAbbuBK9ewLTtgYrPH/+8EchQI47YundeH+8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SHX4qgNtfYNvxvsJlX4nnnXDtfLWEB3uXQ+ND2Wsz3ECgEcA6gZGuJ5elaDheO6Gn
         mnJ29ca5QyPtF1wFL+qvhkWnz9lYW9d1y1M+vbKKgmfiveaEYDTu7UN8CBiqJXh5Pv
         6qnljnixXqnGzJfFcFAQymqD4bkuw2cdgThKyrir/YciqemCGj5uVP4SHITUKMNoAO
         c9ZZnFzLSdbB7HvKSTZgMtEL+suOtPawV1pMy0LAGhPYa4cvOmqtVWB3wTbTmfdNdQ
         /4O68a51/S7VQhriUM7Ko0kZMYf6Rt1qzTG3pNLjmnvJdS6xnIw9oR0LfnmhHQf0WX
         lcS5k9UFQaqrw==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1i9xVL-0001BB-CN; Mon, 16 Sep 2019 13:21:47 -0700
Date:   Mon, 16 Sep 2019 13:21:47 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org, John Covici <covici@ccs.covici.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190916202146.GA4145@gregn.net>
References: <875znqhia0.fsf@cmbmachine.messageid.invalid>
 <m3sgqucs1x.wl-covici@ccs.covici.com>
 <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
 <20190821222209.GA4577@gregn.net>
 <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
 <20190909025429.GA4144@gregn.net>
 <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
 <20190915134300.GA552892@kroah.com>
 <CAOtcWM2MD-Z1tg7gdgzrXiv7y62JrV7eHnTgXpv-LFW7zRApjg@mail.gmail.com>
 <20190916134727.4gi6rvz4sm6znrqc@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916134727.4gi6rvz4sm6znrqc@function>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.101.4 at vserver
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:47:28PM +0200, Samuel Thibault wrote:
> Okash Khawaja, le dim. 15 sept. 2019 19:41:30 +0100, a ecrit:
> > I have attached the descriptions.
> 
> Attachment is missing :)
> 
> Samuel

Samuel, check the message that came to you directly, and it should be
there. The speakup list rejects attachments.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
