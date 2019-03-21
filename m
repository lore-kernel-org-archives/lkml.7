Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C055FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD7821917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553206523;
	bh=vhoF3Kso97rxOzuYiq37/5Bm0UAQPTYhLxOiBawJoQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NQmB044r1P8w5iTGUnqphctOtGp2Qic7/ul3SZOdJXR67eoQd/qLMBgKdFgK9G8vL
	 Q1RPQrgQqNjAp31AwrCy/ShEPCDeWFnazUSR+BOqZmvfLT7rP+xptN6F8PpACfU8YI
	 p+VCc1QaFK88xQIdwg/EmLbf/zGYb4DJ9olNj+pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCUWPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:15:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCUWPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:15:21 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEF25EB6;
        Thu, 21 Mar 2019 22:15:20 +0000 (UTC)
Date:   Thu, 21 Mar 2019 15:15:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org, Daniel Walker <dwalker@fifo99.com>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-Id: <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
In-Reply-To: <20190321151308.yt6uc3mxgppm5zko@zorba>
References: <20190319232448.45964-2-danielwa@cisco.com>
        <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
        <20190320232328.3bijcxek2yg43a25@zorba>
        <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
        <20190321151308.yt6uc3mxgppm5zko@zorba>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:13:08 -0700 Daniel Walker <danielwa@cisco.com> wrote:

> > The patches (or some version of them) are already in linux-next,
> > which messes me up.  I'll disable them for now.
>  
> Those are from my tree, but I remove them when you picked up the series. The
> next linux-next should not have them.

Yup, thanks, all looks good now.
