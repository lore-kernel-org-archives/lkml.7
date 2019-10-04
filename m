Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E65C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DA021D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570185447;
	bh=iBQF2+NS3IUMK5BhUwN9rX2yg8DwSDs2+jK+wIGNkkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oR0sNluLhq7bn31z0jmTaBZaDuQpNd2gz+BAFZ73GivZhVcXI0hL3IkabLgdm6ZzX
	 4zrYNxgbcjFlAgGYCyBcAtxPKCIfmXuGckC58yecGPP8UBKU3B3pQUdBg7yUbDVsns
	 +EnG8ug6T2BirSX4nxGt4/xkfwGnmiRk4nhC19+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbfJDKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfJDKh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:37:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D6B215EA;
        Fri,  4 Oct 2019 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570185446;
        bh=iBQF2+NS3IUMK5BhUwN9rX2yg8DwSDs2+jK+wIGNkkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ign7A6WyVcqgWtlm8J4o3Lamf2+hcDBoVklGntADdUH0ePlfnG02YAsHEfXfTsOwz
         Wo8n+BSt9/5agQ6bgT/JE2am3QYMnfMsmztBqBCxOWFiohmgPvIDtBcX/2D3jAfiX2
         nnQATchgEYXKtKxYaP1aztOMER2qfHnYKK9OFAoY=
Date:   Fri, 4 Oct 2019 11:37:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64/cpufeature: Fix + doc update
Message-ID: <20191004103721.tnjii772ts72pnm5@willie-the-truck>
References: <20191003111211.483-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003111211.483-1-julien.grall@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:12:07PM +0100, Julien Grall wrote:
> This patch fix an issue related to exposing the FRINT capability to
> userspace (see patch #1). The rest is documentation update.
>
For patches 2-4:

Acked-by: Will Deacon <will@kernel.org>

Catalin can take them for 5.5, since I don't think they're urgent.

Will
