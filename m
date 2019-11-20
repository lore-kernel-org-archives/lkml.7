Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C86C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE61D2088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574268937;
	bh=8FrHjGta+6jwWJXLwHTgBvG6rHWnBmFRWE1CWfOKi2I=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=vMMl8AI+r036wYAUArXAzTIVtOlhrFYnwhyxYYjMPeY5U2LtJ9FgnPmvcStqiX0xo
	 WvmDgkQOMpGJ9NLSKlaeB0X47b7jnMnIACKPI33DXt20g2UT3YgcueBN5J9iHhTdNq
	 rVS/j8LWQLqO9guGvOgk6C1HGYjbGvefpM9yXw38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfKTQzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfKTQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:55:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40E62071F;
        Wed, 20 Nov 2019 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574268935;
        bh=8FrHjGta+6jwWJXLwHTgBvG6rHWnBmFRWE1CWfOKi2I=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GuaUCGXRy69UGMILRhEiXMQht7KknaeqSwn+pkg/GnFmDDi44IhBbx08jJcgAkU5O
         JKaj0sp6QY8rmyw6QWibarbtgNwmXj76E/oNNTaTytyuju0eZnU6EensCUxr+w/3tG
         vlm6pFo8SE7DrAHPxscB+DzfIitfTsBVG8quudHE=
Date:   Wed, 20 Nov 2019 17:55:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: fbtft: Fix Kconfig indentation
Message-ID: <20191120165533.GA3027865@kroah.com>
References: <20191120133911.13539-1-krzk@kernel.org>
 <20191120164155.GR30416@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120164155.GR30416@phenom.ffwll.local>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 05:41:55PM +0100, Daniel Vetter wrote:
> On Wed, Nov 20, 2019 at 09:39:11PM +0800, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I expect Greg will pick this up.

Already picked up :)

thanks for the review,

greg k-h
