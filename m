Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B51C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253412087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369776;
	bh=VTEMkRxAEwAAhO8YkZ35ckyyOspKUqhkHhSKIJZnN28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=10EB9aKCXc9++lVHRWZmvpCZEkOB4lxfdaHQ8S5+glidpompRWUWMihR/So8p/wYb
	 XTWUttnlI21rH0jnIVn6+nW38NjEOmeRI1EdR3mX4TQPAuGflScDP/yJtb4G9Ylpkj
	 CSXSxWlZRbEHmmawU8M3CmIgYxEweJHs/NyV0P0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfD0M4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfD0M4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:56:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEA22087C;
        Sat, 27 Apr 2019 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369768;
        bh=VTEMkRxAEwAAhO8YkZ35ckyyOspKUqhkHhSKIJZnN28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFP7c9CJLoHipg0tqL/Y/MGUW3F5gGPjJVmDFER45me8zC4U8kDUnPput1M8W/wmX
         j+uhlrb93vHMCPj4HrQfXusvDtrOiujFcDAR2Roz97eOHIqpdV2vTTHdU5zsM7SIsn
         rGugvWpi1aSYPkoG+Gi8pLYLz8o9aTABwQu2xtwo=
Date:   Sat, 27 Apr 2019 14:56:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Message-ID: <20190427125606.GA25493@kroah.com>
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYXPR01MB1775A4A3AF86097F284C4A08C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <20190301161624.GA19937@kroah.com>
 <TYXPR01MB17756DBAF2FD7A1F2A9B82B0C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <TY1PR01MB1770DB45DCD263C6933B9210C0230@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770DB45DCD263C6933B9210C0230@TY1PR01MB1770.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:32:59PM +0000, Fabrizio Castro wrote:
> Hello Simon,
> 
> I know you don't normally take this type of patches, but this one has
> been around for more than 4 months now, and I am losing hope here...
> 
> Do you think you can this patch?

I think this got dropped somehow, sorry about that.

Can you resend it, with the acks that have been given to it, and I will
be glad to queue it up.

thanks,

greg k-h
