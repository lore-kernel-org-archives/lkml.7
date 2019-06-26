Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C86C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EAC2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="BttHxzSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfFZGHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:07:52 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:44884 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZGHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:07:52 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id D98F52DC0076;
        Wed, 26 Jun 2019 02:07:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1561529271;
        bh=PnFeQBJrBN0kuPckvbbLTpCe2ZTzGtXQh9GKRCi7Ozs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BttHxzSaxRhW0isT2fne0Z55T1QSz5OBnpx9RWir+fLdNA2wE4jiPDVwjkyGHC9AF
         0INk3Bu4w6G17+EreKMoSem+ZtX0p5Aa1MC5q6/pCEkQStrEkUsbMYXQAVTYFr4PrE
         6Qz7U6ASgXZtL/VjI4RhWaWyfUbQKktaUKB6xCMFSoMkan678M1w9HpZveIoTc+qMv
         RROctM+3nYh7EO+7AHBf+aALlOXg2XAPhkPJVaPnEV9sl+d6zh6WuFQNwOmtzyIf/y
         hR1yrYRO2l1WDCNPtuokzg9JDeIho0VvN9ejxu62AyDFc5WS30gWXoOtxZLk1vTFEo
         rmlsAdFEgOBjEKBZswnFgpODUXjPZ4IAo97MmBqCPp2BfUCovjYCI7TC756PWXQnrA
         HvM628Ho1XwwCZwadX5fiAkjG/b5JyrKGVBNTMjEWAuMDP+U2bQLeJ63eA3kkPqEKr
         W9W07si6/D+GBdwsN/M+Asayo/L8E2stRQpFDHs7cAB/D/xHP51FZzDTzuNYeDNF9E
         nf+Et+4iuDgjP4q2popE29viGXt4sbnwPpSHQnoUkril4UQ2+NDQhIJkMH+8szo/9u
         /FJT7YzYhj6MlnN+arpU7Y8QanfNH3Fw5Jn8Mu1h5s36jprug5CMa7gm0C4JRMDP2x
         iBtIMbaHr+tfUiXskNLhSsZg=
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x5Q67U6a031223
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 16:07:46 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <214e5c621bf101a92c7abdf815a7300f0dacf496.camel@d-silva.org>
Subject: Re: [PATCH] nvdimm: remove prototypes for nonexistent functions
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 16:07:29 +1000
In-Reply-To: <20190626060350.15715-1-alastair@au1.ibm.com>
References: <20190626060350.15715-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Wed, 26 Jun 2019 16:07:46 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 16:03 +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> These functions don't exist, so remove the prototypes for them.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/nvdimm/nd-core.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index 391e88de3a29..57d162dbefaa 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -136,11 +136,7 @@ void nd_region_disable(struct nvdimm_bus
> *nvdimm_bus, struct device *dev);
>  int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus);
>  void nvdimm_bus_destroy_ndctl(struct nvdimm_bus *nvdimm_bus);
>  void nd_synchronize(void);
> -int nvdimm_bus_register_dimms(struct nvdimm_bus *nvdimm_bus);
> -int nvdimm_bus_register_regions(struct nvdimm_bus *nvdimm_bus);
> -int nvdimm_bus_init_interleave_sets(struct nvdimm_bus *nvdimm_bus);
>  void __nd_device_register(struct device *dev);
> -int nd_match_dimm(struct device *dev, void *data);
>  struct nd_label_id;
>  char *nd_label_gen_id(struct nd_label_id *label_id, u8 *uuid, u32
> flags);
>  bool nd_is_uuid_unique(struct device *dev, u8 *uuid);


Whoops, fat-fingered this, nothing has changed.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


