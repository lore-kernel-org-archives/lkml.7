Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C4C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAD721019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="GzlDuGFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDFRm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:42:29 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:40672 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDFRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=WsLu237ZMm6t4oaB0C7WrpDI6rE2dRmv0yGKW/np6go=; b=GzlDuGFID6tsZ/+joc3/hz6lo2
        4drLVX5PI4CzxM5bZSBZ7h6vx2WuNbb9C7k6BquZg81XuBF3uxTA44L9Fvr3jDQ8DYsQFdoFzeHC4
        N6ECbYPun6nxQLbnjMIRm6w91CW5zmej9FX8a9r5y1+INV6Z/qb9zwM1LSX6Eg020GuY=;
Received: from [134.3.47.207] (helo=t470p.stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1hCpKj-0000l7-Tc; Sat, 06 Apr 2019 19:42:26 +0200
Date:   Sat, 6 Apr 2019 19:42:24 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: fix compilation when KPROBE_EVENTS is enabled
 without kretpobes
Message-ID: <20190406174224.GB5538@t470p.stackframe.org>
References: <20190406155543.15353-1-svens@stackframe.org>
 <1554570896.uirb80qggp.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554570896.uirb80qggp.naveen@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Sat, Apr 06, 2019 at 10:52:47PM +0530, Naveen N. Rao wrote:
> Sven Schnelle wrote:
> > While implementing kprobes on PA-RISC (without kretprobes) compilation
> > fails when CONFIG_KPROBE_EVENTS is enabled:
> 
> Thanks for working on that! Is there a specific reason kretprobes is not
> being enabled on parisc?

Reason is that i just started to add kprobes support to PA-RISC. I'm planning
doing kretprobes as a second step and have separate patches for kprobe and
kretprobe to keep things small.

Regards
Sven
