Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8784EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65601208CA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfGALy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:54:58 -0400
Received: from 8bytes.org ([81.169.241.247]:33612 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfGALy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:54:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6E2E3229; Mon,  1 Jul 2019 13:54:56 +0200 (CEST)
Date:   Mon, 1 Jul 2019 13:54:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kevin Mitchell <kevmitch@arista.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] handle init errors more gracefully in amd_iommu
Message-ID: <20190701115454.GB8166@8bytes.org>
References: <20190612215203.12711-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612215203.12711-1-kevmitch@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, Jun 12, 2019 at 02:52:01PM -0700, Kevin Mitchell wrote:
> I have tested this series on a variety of AMD CPUs with firmware
> exhibiting the issue. I have additionally tested on platforms where the
> firmware has been fixed. I tried both with and without amd_iommu=off. I
> have also tested on older CPUs where no IOMMU is detected and even one
> where the GART driver ends up running.

Thanks for the fixes, applied them all.

