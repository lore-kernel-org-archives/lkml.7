Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0972184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="etilclbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCTOjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:39:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8bDDiC9zgyi/MQcMouS7nG4D1gn03i8mK1JY09omNT4=; b=etilclbD7GLJUVzYWL9uXpXV4
        uMNGH/9tJumu03Pildc9FUiUk6l0zi497VSrb07ErLhpHjeWzbY1kyOz0kphRzbmWeGMIaUA5p2D5
        MzFKDLaoSCTpJCTnsq1nXgByGPXRQhhNS3amkJcA6QkRKAhYxXldGGSvsloKxv0eYn5SzSdJuc6zF
        2Ro/VQnstf0Un+HHyJq7E/9a8PpjV6Di7A4mEojrIKqEoLxZaZtUOP2IasDR0oV6EH81Ma9yGS5Aj
        uNTVhW/jgEvWY4TnBDamQ+u5SVoKL45urH+Ev/ClXb1t1ojze4NrnBeFYDpALhNXmbgRMX0F06Qpk
        iDBjCqnbA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6cNX-0002T2-D8; Wed, 20 Mar 2019 14:39:39 +0000
Subject: Re: linux-next: Tree for Mar 20 (drivers/gpu/drm/i915/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20190320141849.34e569f8@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a6bb676-39fc-295a-74eb-a83c439e5b22@infradead.org>
Date:   Wed, 20 Mar 2019 07:39:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320141849.34e569f8@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 8:18 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190319:
> 

using: gcc (SUSE Linux) 4.8.5

beginning yesterday (20190319), I am seeing problems in i915_reg.h on x86_64:
(multiple instances of one macro in the header file)


../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant
../drivers/gpu/drm/i915/i915_reg.h:167:27: error: first argument to ‘__builtin_choose_expr’ not a constant
../include/linux/build_bug.h:16:45: error: bit-field ‘<anonymous>’ width not an integer constant



-- 
~Randy
