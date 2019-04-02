Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46E421473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554206464;
	bh=zRUah+vyw0b+iE48UYAJp5FZXgeS2krs6CMknEmzFR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N8jKhvj1L3LPxwwRVaBERUcWnikaJDUbkqbX/bTt4Q982U526eN9maWIzsyPaPkyf
	 UWb3Q0ON/A/54MS8zMwuO1XayTJx+WCdZWSJBDMuzSda5jgsdoc9Ds7+cykcLxdEjQ
	 lJWxZwTtvAnJYBoslzySc/BFKi142xnqJ1D4bOWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfDBMBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbfDBMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:01:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD0721473;
        Tue,  2 Apr 2019 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554206462;
        bh=zRUah+vyw0b+iE48UYAJp5FZXgeS2krs6CMknEmzFR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFMRFXUbL8E+le+cCSk7QK3ZtPiYg/YQUmK5Ok1yog+c11VJIffTWBSsRgwe6sbg3
         PnbLPW2aqeAimof8s/bPJUY5B977qbjLpkT7DETtIiTUuAoVPrBVxcKnEB1v9s62AH
         65PPiRKBWeuVTNQfB8E+IKsjkJMChXHFm+PnAbQs=
Date:   Tue, 2 Apr 2019 14:00:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     trivial@kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: kernfs: Corrected spelling mistake
Message-ID: <20190402120059.GA24119@kroah.com>
References: <20190402114414.23767-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402114414.23767-1-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 01:44:14PM +0200, Christina Quast wrote:
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>

I can't take patches without any changelog text at all, sorry.

Please fix up and resend.

greg k-h
