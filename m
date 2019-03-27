Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E23C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDF8213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553648391;
	bh=VlXHwIt0W8ZdU1lUVZ+pbNWPd6ZDD3Bm8/y77PS/pZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tKF4J8BXh25ePQqEeQFhQUxiz/bydk38fYyDlGEaFDIUDG8xOLDTD/0hhrkooaQUa
	 SgfRQ67QUC9g9a8K9apUrHex/NVF7PgACTwMcRCiV12vG8AjfGzkWfkbMkyf++2Ulz
	 44fKWyNuowKbaCTn/B31UxNJqe096RVl8i/v1Iuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfC0A7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0A7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:59:49 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 382FD2075D;
        Wed, 27 Mar 2019 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553648388;
        bh=VlXHwIt0W8ZdU1lUVZ+pbNWPd6ZDD3Bm8/y77PS/pZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzW6elez9ymQZWwWZbaext18hLSt+/jXtSxRvWNzAtlXLMqbSjAivWrURg3iTHkSS
         9WaOpl7dxPOKa3JIyFYAVeMx9tXxqkstyjoenimc5h9I25F4A3n96aIRuBeG9rV+Bf
         NqyJ2p4v6IgrRIqk9W++E6Tx2l5OdzoK3+RfZUxE=
Date:   Wed, 27 Mar 2019 09:59:44 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jslaby@suse.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Add new features for the Spreadtrum serial
 controller
Message-ID: <20190327005944.GA20301@kroah.com>
References: <cover.1551689518.git.baolin.wang@linaro.org>
 <CAMz4kuJitF7Q76T0Hoj1-UTAjQnepEs9aQHhy=r_Acdq+RiwGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuJitF7Q76T0Hoj1-UTAjQnepEs9aQHhy=r_Acdq+RiwGw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 06:41:31PM +0800, Baolin Wang wrote:
> Hi Greg,
> 
> On Mon, 4 Mar 2019 at 16:59, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > This patch set fixes the baud rate calculation formula issue, as well as
> > adding power management support and DMA mode support for the Spreadtrum
> > serial controller.
> >
> > Changes from v1:
> >  - The patch 1 of V1 was applied, so remove the baud rate fix from this patch set.
> >  - Add reviewed tag from Rob for patch 1.
> >  - Fix the incorrect names' order in patch 3.
> 
> Could you apply this patch set if no objection from you? Thanks.

It's in my to-review queue, sorry, will get to it soon...

greg k-h
