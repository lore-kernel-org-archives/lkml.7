Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE2C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC53216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="vW9WPk4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfFZTsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:48:35 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:46575 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=urbmOvjVKXQZVTiwQboR9i8OCllVlqPVema0/C5H3iw=; b=vW9WPk4zAG/EQFBSdhSK5HaDDC
        UVlp/qtRXZiaRUCOYoZPtczYYArpGFpbPbrsEHgaqEGIL7IOVGl1mIfshv1ho1jD2Q7Q9zZ1Y9CnR
        PS9dee2woHZioRpYMv+bz1TvbGbDv17eHt8lwRgRBZLbxBvzWyE1ZiDV8UdjUbbCXvreX3cZXVHqW
        nNAOrpAFGciz9eMBEFPb3Yy5cbeZV6Pbz8w9NgUL/2NImxpoAVh5EiuzKOotEvSkepByzRKVZWduL
        mniz+0yPUVpQSSHqm/b7d1Z6jkJUhac6zPsmQCTGjZwaT2uZRMNdKFeqblbs8wtJFOPXCZxkDDLg5
        Px935zdg==;
Received: from web1.kapsi.fi ([2001:67c:1be8::146] helo=roundcube.kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1hgDuB-0007at-Nr; Wed, 26 Jun 2019 22:48:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Jun 2019 22:48:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: On Nitrokey Pro's ECC support
In-Reply-To: <20190626092817.3e5343e6@lwn.net>
References: <c9c1e7f83a55bc5fb621e2e4e1dab90c5b3aac01.camel@iki.fi>
 <20190626082541.2cd5897c@lwn.net> <20190626152138.GA28688@chatter.i7.local>
 <20190626092817.3e5343e6@lwn.net>
Message-ID: <66860f89606c3e5bb4472aadab2fe470@iki.fi>
X-Sender: jarkko.sakkinen@iki.fi
User-Agent: Roundcube Webmail/1.3.3
X-SA-Exim-Connect-IP: 2001:67c:1be8::146
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-26 18:28, Jonathan Corbet wrote:
> On Wed, 26 Jun 2019 11:21:38 -0400
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> 
>> >Maybe Konstantin (copied) might be willing to supply an update to the
>> >document to reflect this?
>> 
>> Hello:
>> 
>> I just sent a patch with updates that reflect ECC capabilities in 
>> newer
>> devices.
> 
> Hey, man, that took you just under an hour to get done.  We can't all 
> just
> wait around while you twiddle your thumbs... :)
> 
> Seriously, though, thanks for doing this,
> 
> jon

+1 :-)

/Jarkko
