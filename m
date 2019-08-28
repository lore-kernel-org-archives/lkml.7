Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NL0QwD9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfH1B17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:27:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1B17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SsIBUUgqWoBft4g1qjISTKId449C/sPPvMGvzOhucFA=; b=NL0QwD9+KL+vnxXxnHD22icys
        mAORzuHaSIFUSHIhL3+yR6+3Kw+Qw6J/6PoYN0NLBELIl+FOSjq3AKOVb+iL+oSavoNWl9TEY6MtG
        ER7D89Yy16NJQ0AGslo98M6jwxfxiSGSs7N2/iUCcAJuhq0XUj+Cql+pHW58ej07QMxahlx7gxTr3
        bZgEBi9/26cO2G+efQVHUSRUCfF2WAZ3RT2cIoL7eQvyTkU+ay4lxFe38y0ds4WEwvDUppyReQeiK
        2/B425Y0hB/FAL3qGJg25iXIW4jLLKzEd7qJOMUDbQ5Jbav0vEpQGjFjIXP+Tn6sROyOQ47FbLVNk
        zNEYwo2fg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2mkf-00068z-5y; Wed, 28 Aug 2019 01:27:57 +0000
Subject: Re: mmotm 2019-08-24-16-02 uploaded (intel_drv.h header check)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20190824230323.REILuVBbY%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b08dbe92-8e10-aa3a-7f92-12b53ee5b368@infradead.org>
Date:   Tue, 27 Aug 2019 18:27:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824230323.REILuVBbY%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/19 4:03 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-08-24-16-02 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.

on x86_64 or i386:

  CC      drivers/gpu/drm/i915/intel_drv.h.s
In file included from <command-line>:0:0:
./../drivers/gpu/drm/i915/intel_drv.h:402:24: error: field ‘force_audio’ has incomplete type
  enum hdmi_force_audio force_audio;
                        ^~~~~~~~~~~
./../drivers/gpu/drm/i915/intel_drv.h:1228:20: error: field ‘tc_type’ has incomplete type
  enum tc_port_type tc_type;
                    ^~~~~~~


-- 
~Randy
