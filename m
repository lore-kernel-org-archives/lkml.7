Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C805C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE3B2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="bq3eED76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfHZO0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:26:41 -0400
Received: from sonic304-22.consmr.mail.ir2.yahoo.com ([77.238.179.147]:44721
        "EHLO sonic304-22.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727261AbfHZO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566829598; bh=CUkBeBfgzLsQe0R+nv4XKH1MrZ/TAXoqFxsCZAILlnI=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=bq3eED76epCDJIxamRYyr9sVqUGuOYMvQFQQFGqDNfecn5ql4Xy6BR2HXyEHIcWx4ooDVO4llNLPqn78ocoHN/Knm19DfR8B1r624qSp/8LPCAsYliyPDvL1DdqT6ZlGri4E9y3rhFFqWFaZlHsRsTcgUHwLRgt9Jj9+ImpW9YDTLSDIudai4a/MPpIDJ6+SMo2gHgE3ulEAraZnaN5cAkyfdjeU8zXVCsTb9fobbObE4gfiQ/p5qjMhSzfGTuYE9xSlqoV+iVZnrdjT50PQDUcjz4X7k5qxSNbkCqUCm7tAQAGivO7qNkizRHC2fqJgJpkEQ59wmRAl9bncS3/huw==
X-YMail-OSG: OgJk5BoVM1mL53bHC0NY6P6qwaZ9ctS1dz75ao.5HYcla4P0MsHPxuQL1_Ra54H
 TGKIkokmuTrdH9vc_7nHkGzdPHoeKfQ7yY1dKf00eCqVpKuqpwKoOyfPgFOCDA4Xq5cGTw23hhqB
 kgrTbL9p.oXiOqTPc8Ml1Al4RcTdkBmhmEhEe2eeE6OuKcIBzVh7LGXKQDo_hLJZ47YdpgvBh2He
 r0rBZZooM0wTXDXaaF8MMh1bd.fwoZImN.K8SyJWrG6f6amjl2rdf50_b.jl2Q3xfDR3adxlsaeL
 c5mKZHqtYGu_Sn3jFKBVOupqKjmAjCTJNo8y5oBLt5Qainv49b65GciX5HWXMsGdyP990Ob9bzQG
 W7YLWBaE_nFBzNRCLws49KWHqVxHI5RBDBqPqkHOFVhlYbpaOeNLwrSG2aLg6_cNNLaIq.dEtJpr
 uqNDeC1d1ndMUx8ugKjP0CCSZWQqDCRuCITev386kCzC2u9EwOh9F1GC71SC0Ohd19Yr_cV60zUE
 7LKkLo4CsaLqaBt5YbdiAuSqCUSnEG1EUPdius4JPYHydQcUn7WC0l6DD95D.SNBC9KohMfnGAQa
 FfHxDhV9hrY2nzForWUspe6311PcTJ2NIWcXBKB06fIuq5Lytvk1iB9Y2UuKl2zf.aNVOutZW1mr
 p33SiRmRAcxdzTYeWJ0yDxI_.AfSOhFmLis_20hj37g3wuW4pJrcohDycAJxKzy3C8UggHPVbLIv
 gIC4PoPmPHHgjAt6RRsCeKcqdGRkW2I38zhs.ioGYwuMYU5GUEyEbH2n818kUYvOjLpJ_twTVJnv
 e8.0qPsOoiac6wfgPbjI.1mGvc_ww.DAgIDWaPrcH9bBlIhN8ICQn3S8OuJsW1StWsaCCMj2uZ.E
 qkHkT4kFx3RHoRSPJUziJG.X8lUzAoJp.E.nZ.C33buUdsqHK8XGpJZPYveg4_dARColOQKF9ZCc
 x3di6Y.6S0eUfmew_fX3Nu9f3dokyd2y7cuwq_KAO7sITZnQzYA2FEpjFqr_CCJmWTsR8bOu_q5F
 Uu3V0_4aqjU4YOJe3zGx.I9.sjMImskhGhSfaHtlfRSQlPZy.koikLlUqFUP1e3GCjWoO07iud1e
 DekJJT5XCSu96mLI_N6ZjehRTEJKcsUBQt.L3MuKgFG37fh0KG_9BOoAP5CVpdnfSBWN2MCZOKse
 y.Kro6fIK1UzEbQMJ2REwHTp8hmsRN_TYauG3Yll95d3xhKIuwCVDKCZ1EIlTu4euyV3skioCDB7
 k7q.y.ZwuhZ6097iQU58tZc1Z9SftK39Qek2N0w7eQ4ni2esuqOur
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Mon, 26 Aug 2019 14:26:38 +0000
Received: by smtp417.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1d766d3174bb217f1c7ce281052272e3;
          Mon, 26 Aug 2019 14:26:36 +0000 (UTC)
Date:   Mon, 26 Aug 2019 22:26:26 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH RESEND] erofs: fix compile warnings when moving out
 include/trace/events/erofs.h
Message-ID: <20190826142624.GA22424@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190826132234.96939-1-gaoxiang25@huawei.com>
 <20190826132653.100731-1-gaoxiang25@huawei.com>
 <50c3453c-a1be-3e79-da21-4d4c84d49fec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c3453c-a1be-3e79-da21-4d4c84d49fec@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Aug 26, 2019 at 09:51:35PM +0800, Chao Yu wrote:
> On 2019-8-26 21:26, Gao Xiang wrote:

[]

> >  TRACE_EVENT(erofs_lookup,
> >  ^~~~~~~~~~~
> > include/trace/events/erofs.h:28:2: note: in expansion of macro 'TP_PROTO'
> >   TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
> >   ^~~~~~~~
> > 
> > That makes me very confused since most original EROFS tracepoint code
> > was taken from f2fs, and finally I found
> > 
> > commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")
> > 
> > It seems these warnings are generated from KERNEL_HEADER_TEST feature and
> > ext4/f2fs tracepoint files were in blacklist.
> 
> For f2fs.h, it will be only used by f2fs module, I guess it's okay to let it
> stay in blacklist...


Yes, it depends on you f2fs folks selection...
Anyway, this file is a new file, therefore it should be better not to add to
blacklist...


> 
> > 
> > Anyway, let's fix these issues for KERNEL_HEADER_TEST feature instead
> > of adding to blacklist...
> > 
> > [1] https://lore.kernel.org/lkml/20190826162432.11100665@canb.auug.org.au/
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>


Thanks for reviewing :)


Thanks,
Gao Xiang

> 
> Thanks,

