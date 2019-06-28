Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB175C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E4C208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723140;
	bh=4pCd1Ayxj1tcT9GyFzeoQOU+e6oFR74xvxSxPqym7Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dRWGj/1IjA3gGAgMnNhS5WlGolNLRFchCPM7b8s5VwyrfnGl0vKmQQDRLYJBCEHpj
	 dGI8zfSwoHsTEzqbSUDUw7DOmQvSW7G+uj6txvD5fGcjcCidCC5IPpWdCZbQnpcx0i
	 4fRecobUPhBazzqx8UIY761j1bdp21Awe92hgLiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfF1L67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:58:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfF1L67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AF3AB627;
        Fri, 28 Jun 2019 11:58:57 +0000 (UTC)
Date:   Fri, 28 Jun 2019 13:58:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
Message-ID: <20190628115851.GH2751@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-2-alastair@au1.ibm.com>
 <20190626062113.GF17798@dhcp22.suse.cz>
 <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
 <20190626065751.GK17798@dhcp22.suse.cz>
 <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
 <20190627080724.GK17798@dhcp22.suse.cz>
 <634a6b8e-3113-f0af-f8d3-9b766f8cd376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634a6b8e-3113-f0af-f8d3-9b766f8cd376@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-06-19 13:37:07, David Hildenbrand wrote:
> VM_BUG_ON is only really active with CONFIG_DEBUG_VM. On
> !CONFIG_DEBUG_VM it translated to BUILD_BUG_ON_INVALID(), which is a
> compile-time only check.
> 
> Or am I missing something?

You are not missing anything.
-- 
Michal Hocko
SUSE Labs
