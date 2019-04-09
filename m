Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B07C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8D821473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554778972;
	bh=t5lw2qiEV7u1MtseXj9orZVuUVyZtBqwN7cNHwi+l4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RauqYK/LK3aRxWJ0yBKxJA8DgVTC49bJXubq/9lbAi0VJREqMNPj3+L5jaTE/ud+D
	 37wXj90Knp1VlKUVRYaHgme38IysaNVD08G3pSvO8NKPIhtIxL5wQYOj5ifJFeFYod
	 XNoVCKVOnM8Dt17bGig6qPbIIESbNPJ1UOOYfXCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIDCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfDIDCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:02:51 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EB320883;
        Tue,  9 Apr 2019 03:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554778970;
        bh=t5lw2qiEV7u1MtseXj9orZVuUVyZtBqwN7cNHwi+l4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2bhE8Sbjuk9jyJKrtShYLySVEYb5pQrGpE62ml0qxRkjLRO099Om7Qws+zEpmPRd4
         tJrBRDWYaplPia1YS1Ujm0SWLMX2DpatrJaBnvkMW3KibxJi7RFJ+Nos3Zo97PpBN/
         XU0sGymKChUEgBS/lVwKPHD/ZvHqGk4jxO8rHzNU=
Date:   Tue, 9 Apr 2019 11:02:31 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] RISC-V: Implement ASID allocator
Message-ID: <20190409030231.GA14861@guoren-Inspiron-7460>
References: <20190328063211.13052-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328063211.13052-1-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Thu, Mar 28, 2019 at 06:32:36AM +0000, Anup Patel wrote:
> This patch is tested on QEMU/virt machine and SiFive Unleashed board.
> On QEMU/virt machine, we see 10% (approx) performance improvement with
> SW emulated TLBs provided by QEMU. Unfortunately, ASID bits of SATP CSR
> are not implemented on SiFive Unleashed board so we don't see any change
> in performance.
Can you tell me what is the test case ?

Best Regards
 Guo Ren
