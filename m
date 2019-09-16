Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1FAC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BF821670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568643064;
	bh=KnemdeMyQ/2j7M+jgLtO0ojPQamllSV0Dtziui3+UIk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Pz/zgKbeEKELq38CUVrWO8rzRUvX+4acY7EQT1nA5sHJYTYvVmqwRbQkmB2i5rpez
	 ZpaIyHgU9WmdKIu6kGIFEcrgQfKPtNP0EdNhcl8wFmvbizNFtk/2AE/TAQFW6su2uA
	 7w2e67M4SfRENpdCYPleah16KPNBi4iPWTyXeUcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfIPOLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfIPOLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:11:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC2020650;
        Mon, 16 Sep 2019 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568643062;
        bh=KnemdeMyQ/2j7M+jgLtO0ojPQamllSV0Dtziui3+UIk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FYl2FbXUd3XNdfiDv9+MABfCYTEIbQo1DYWseaM8p2AI+FMuyNAAFVA70XAgzBkVb
         uEzhheNYmByMDbz2oVQfcTLaPHNQNl1+Ln+IipsMjD56UUIpJtZrw4cnhXhQNJD5Me
         ZfwGd5VNyC377vISrG0O5RcYGxaF4FaXZU5mKcqQ=
Date:   Mon, 16 Sep 2019 16:11:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190916141100.GA1595107@kroah.com>
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
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:47:28PM +0200, Samuel Thibault wrote:
> Okash Khawaja, le dim. 15 sept. 2019 19:41:30 +0100, a ecrit:
> > I have attached the descriptions.
> 
> Attachment is missing :)

I saw it :)

Anyway, please put the Description: lines without a blank after that,
with the description text starting on that same line.

thanks!

greg k-h
