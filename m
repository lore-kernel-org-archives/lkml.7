Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E488C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7EC2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551456990;
	bh=NDfzO3SfCEkr6OgBJ8krWyr3OpPO03Oo4mGMgNjzxLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ki+RAB5H6pcoaw5n9XQHnRVr4v6a8fOgKtrB06rByQKGLdiE83B2NpsoQAF+yzDLX
	 vYesXOja0b7i20Euz0789lZB8OlsIJNFgM0Qrm3Zza6dGrEGGozSBDsolyQn3oG1k8
	 FbzJ8NUtoMvIaENPju4dGBQuqtfGp7/HBvOF3nxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbfCAQQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfCAQQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:16:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6AED2083D;
        Fri,  1 Mar 2019 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551456987;
        bh=NDfzO3SfCEkr6OgBJ8krWyr3OpPO03Oo4mGMgNjzxLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR7RMxPW4Bdr0VFnrxQBGzY05MRV8xjQn6qWoyX3KHa0k7nHZn17nOA2zgPLagnhq
         SlCu4b2lEr3IJUEjdPdsCK6ajyR4P981pkO/qsT5O02r5Ctp/RMq4QQeXEsvWONzve
         braArX0iA1rxItg0QW0KBHD7hUoSFSsfQqypau5k=
Date:   Fri, 1 Mar 2019 17:16:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Message-ID: <20190301161624.GA19937@kroah.com>
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TYXPR01MB1775A4A3AF86097F284C4A08C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYXPR01MB1775A4A3AF86097F284C4A08C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:25:33AM +0000, Fabrizio Castro wrote:
> Hello Greg,
> 
> I am sorry to bother you.
> Do you think you take this patch?

device tree bindings need an ack from the DT maintainers before I can
take them.  Also, this is for xhci, the xhci maintainer is responsible
for those, not me :)

thanks,

greg k-h
