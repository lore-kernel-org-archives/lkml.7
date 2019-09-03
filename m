Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBB521897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567540559;
	bh=KY2H9VpXE6kr61OlJCGJzH4WMTvDUw5OjA9w4XBfBZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AxxPHfCm7H61qOs/vuQbnXxIq4C3WAZVWD+2GzYhbHCmcagrLYJpC459cNUQA3SOS
	 MJ/759PEbQhrBmajgfMuguz3ewhCkG9Hjfu34f9MXbECypk58cVyOfaBAG+6ct0Pf+
	 Y072/t/dXAtVNyMvgyYBXKqN/VdxEtYp5O26LKPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfICTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfICTz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:55:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7722F207E0;
        Tue,  3 Sep 2019 19:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567540557;
        bh=KY2H9VpXE6kr61OlJCGJzH4WMTvDUw5OjA9w4XBfBZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLHb0PNZJbBuqC8JrwpmReAsKXUIwkuFty7WXOZC411DqQLhiHdmNAJpAhNfF34v5
         KpuSxcWczhY/zUKGU7q1tkZ7umgfezzRfOijLzlqOjBi0oMTFZMuDHvpV0KFFJHACL
         phkskVh6b7AUnM48mL6wtMdcYw8C4pVEbaiDK+Do=
Date:   Tue, 3 Sep 2019 21:54:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.4
Message-ID: <20190903195459.GC13390@kroah.com>
References: <20190827145146.4735-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827145146.4735-1-kishon@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:21:46PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.4 merge window below. Most of the
> updates here are in Marvell's Armada CP110 COMPHY. It also adds a new
> PHY driver for Lantiq (now Intel) VRX200/ARX300 PCIe PHY. Please see
> the tag message for all the changes.
> 
> Let me know If I have to change something.
> 
> Thanks
> Kishon
> 
> The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:
> 
>   Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.4

Pulled and pushed out, thanks.

greg k-h
