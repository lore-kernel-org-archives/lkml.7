Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9585CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6629F20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563516798;
	bh=3RiI7GWw5a0uMge3N1J/iLfcQwlgjW89372QDUHJ5XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TChcA/3T8cM8ilIX3RCsb/PVEBxqLghPmK2Pvv8N130SGm2XgkY854fyF0mE5U0vm
	 GQcIiLNt3EQQpH07lI4hvD5hivKamveGB4bCk13/+GR2FgW4neyZcbf6hMjYcWS0Lg
	 02Zo3UeMCeLOjqbBLBHL8VghO9Q76cagAJzCJWuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGSGNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSGNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:13:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08C04B07D;
        Fri, 19 Jul 2019 06:13:15 +0000 (UTC)
Date:   Fri, 19 Jul 2019 08:13:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, toshi.kani@hpe.com, rppt@linux.ibm.com,
        richardw.yang@linux.intel.com, pasha.tatashin@soleen.com,
        osalvador@suse.de, logang@deltatee.com, jmoyer@redhat.com,
        jglisse@redhat.com, jgg@mellanox.com, jane.chu@oracle.com,
        hch@lst.de, david@redhat.com, corbet@lwn.net, cai@lca.pw,
        aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [patch 23/38] mm/sparsemem: introduce struct mem_section_usage
Message-ID: <20190719061313.GI30461@dhcp22.suse.cz>
References: <20190718225757.ndUBg%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718225757.ndUBg%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-07-19 15:57:57, Andrew Morton wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> Subject: mm/sparsemem: introduce struct mem_section_usage
> 
> Patch series "mm: Sub-section memory hotplug support", v10.

Has this been properly reviewed after the last rebase and is this
actually ready for merging? I have seen some follow up fixes
http://lkml.kernel.org/r/20190715081549.32577-1-osalvador@suse.de
and do not see those patches being in the pipe line. Or have they been
merged?
-- 
Michal Hocko
SUSE Labs
