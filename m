Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EDCC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B47220665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZQ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:59:51 -0400
Received: from foss.arm.com ([217.140.110.172]:37252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZQ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:59:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6462B;
        Wed, 26 Jun 2019 09:59:51 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90673F706;
        Wed, 26 Jun 2019 09:59:49 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:59:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     jinho lim <jordan.lim@samsung.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, marc.zyngier@arm.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        seroto7@gmail.com, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: rename dump_instr as dump_kernel_instr
Message-ID: <20190626165947.GF29672@arrakis.emea.arm.com>
References: <CGME20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75@epcas1p4.samsung.com>
 <20190626115013.13044-1-jordan.lim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626115013.13044-1-jordan.lim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:50:13PM +0900, jinho lim wrote:
> In traps.c, only __die calls dump_instr.
> However, this function has sub-function as __dump_instr.
> 
> dump_kernel_instr can replace those functions.
> By using aarch64_insn_read, it does not have to change fs to KERNEL_DS.
> 
> Signed-off-by: jinho lim <jordan.lim@samsung.com>

Queued for 5.3. Thanks.

-- 
Catalin
