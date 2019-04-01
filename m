Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E66218FE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554126227;
	bh=eCQ5DV9Tn8h1gxw06T2TtH0LxeThShUo2ZGA/hWOj9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eVB34q7iMK20PsITOssR/rRoljxKUPGMggRxH+gSlHFyFPEix+u6AC3TTjj7A6cQs
	 Oez02OkwpA7N8cbgMriOZdIBNzj7FI5SxX3nhv7CYvx2PSSWpCkO9guzeI6t94wlyC
	 jNQBVQeyHAGbkAtFxq3FxPyzs17No6r/6J7Icsbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDANnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfDANnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:43:45 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA43920883;
        Mon,  1 Apr 2019 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554126224;
        bh=eCQ5DV9Tn8h1gxw06T2TtH0LxeThShUo2ZGA/hWOj9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M46KmpispgEHcy1+IcaOXFB6oxCh+FeUuQRdDGkqb8AOm2ML482OeUw5GLon9s1R8
         sI8K989H43F7k3gSgx3iY9LNASfUzE03S+0D+wANwFveaQevEifjsIdrdCwZ5w1Uej
         G5lAwVnMsXl67mqdo8sw3xHa/15mGSozawab9Gxk=
Date:   Mon, 1 Apr 2019 08:43:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: Fix comment typos
Message-ID: <20190401134341.GA141706@google.com>
References: <20190325181425.247227-1-helgaas@kernel.org>
 <20190325181425.247227-3-helgaas@kernel.org>
 <cc216e0d-cfea-f4b0-dcda-944f67f53247@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc216e0d-cfea-f4b0-dcda-944f67f53247@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 11:26:23PM +0530, Mukesh Ojha wrote:
> On 3/25/2019 11:44 PM, helgaas@kernel.org wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix spelling errors and format function comments consistently.  Changes
> > whitespace and comments only; no functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Added to the patch.  Reviewing this stuff is pretty tedious, so thanks a
lot for looking through this!

Bjorn
