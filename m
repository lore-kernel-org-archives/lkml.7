Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8996C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A31222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570057613;
	bh=o4w7wLOdrvbkNEfei9rVTh9nxdx6sVWimpomN6T6G24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QbiALvCQ9xPwCCAp/3JMQ8Mh1jd12TqB+YpBICQdnYJ8F+A4T/3ZqzzsNWef46MJh
	 nzEbQDXNgG0XRoiv5gXrUJBeFtqyffHPdJE3J8UuH2w4WWgW+QmFrrWBsPg8+cg98P
	 z8xLNPKFVtXCFSMFfRzLs4UDmcYDdrPwNHUhjFFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfJBXGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfJBXGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:06:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5254A21A4C;
        Wed,  2 Oct 2019 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570057610;
        bh=o4w7wLOdrvbkNEfei9rVTh9nxdx6sVWimpomN6T6G24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nM7B8QBANYTsRtBGUkwFXBo1A0/ggrj08BRB23MuxrIX6/hglSl2j8U1NNarCPQQa
         49RpMtd/3qLf2kszGTXTsj85XP3MKadOG/GlfA2qRWAvWyJVpTPXh/kSHt1PcR9/+3
         9iXtLpJtg3B3DwfAA0SNyyC0Hib89alOuodBNP24=
Date:   Wed, 2 Oct 2019 16:06:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] mm, slab: Make kmalloc_info[] contain all types
 of names
Message-Id: <20191002160649.9ab76eabaf5900548c455b02@linux-foundation.org>
In-Reply-To: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
References: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 20:27:25 +0800 Pengfei Li <lpf.vector@gmail.com> wrote:

> Changes in v6
> --
> 1. abandon patch 4-7 (Because there is not enough reason to explain
> that they are beneficial)

So http://lkml.kernel.org/r/20190923004022.GC15734@shao2-debian can no
longer occur?

> Changes in v5
> --
> 1. patch 1/7:
>     - rename SET_KMALLOC_SIZE to INIT_KMALLOC_INFO
> 2. patch 5/7:
>     - fix build errors (Reported-by: kbuild test robot)
>     - make all_kmalloc_info[] static (Reported-by: kbuild test robot)
> 3. patch 6/7:
>     - for robustness, determine kmalloc_cache is !NULL in
>       new_kmalloc_cache()
> 4. add ack tag from David Rientjes
> 



