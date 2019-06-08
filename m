Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC739C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19972146E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559991095;
	bh=Anch2i5T2cHU1w5/a/QPMS2RSvprD02sH8zbY7pO3JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wnXye5SPx+gs+gUR0MuaU1JcaH9T9XnkfX5wToOjEKy35Xung6RSw1QrYg54bBDFW
	 rrZfYelXNApUG6bLqOzgYWYPTEQNTpcaNIcxorgRMTd25k0jIpiG/F4WhdxHBc1d2R
	 a8BP8HISFHZYsrSdXnWbpi1cCwmCQuSaa8Bw+57w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFHKv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:51:29 -0400
Received: from casper.infradead.org ([85.118.1.10]:37456 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mgeScMz6rj/dz5CujtnU7v335CfKeHECqxwDNtzgkgY=; b=GyrjwBj00gZE9eaLRKHfky58Co
        YsT7v1zKxGTRvz3OUQxC2wRK3KGwYNzVaJd373H4vT21rbQ+uXfQf4Fbu1PcDWukxtxDdy4EW14F/
        jFrRYnMRazPXuy3XfTL0BR39hlBuk5CA1M0gb8F4nCw4LMsdqfsVJAibH+ocVsdtyBqxlznRDB68R
        7dqTfCETv2iBfVGkcAVSH85f5+Dd1+4flbQ+VBoWD6GJSXFYBHPZ7rnCcXLlObMLw84xH332yK0G9
        vxf9/2dI2KqhBMn8sWr67PA1PKVI2eFqEOQy0vU6C0DXIcf+ptS4nvZ6myRKE0bfWnXL9BkXQT2FN
        I5k5Swcg==;
Received: from [179.181.119.115] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZYwS-0002D7-9q; Sat, 08 Jun 2019 10:51:20 +0000
Date:   Sat, 8 Jun 2019 07:51:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 17/20] dt: bindings: fix some broken links from
 txt->yaml conversion
Message-ID: <20190608075113.32f2c7bb@coco.lan>
In-Reply-To: <20190607185728.GJ2456@sirena.org.uk>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
        <effeafed3023d8dc5f2440c8d5637ea31c02a533.1559933665.git.mchehab+samsung@kernel.org>
        <20190607185728.GJ2456@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 7 Jun 2019 19:57:28 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Fri, Jun 07, 2019 at 03:54:33PM -0300, Mauro Carvalho Chehab wrote:
> > Some new files got converted to yaml, but references weren't
> > updated accordingly.  
> 
> These should probably just be sent as normal patches rather than tied in
> with the rest of this series...

Thanks for applying it!

Yeah, but the problem with documentation patches is that sometimes
the patches are merged via docs tree, and sometimes via maintainer's
tree, depending on the subsystem.

Anyway, Jon merged this week a patch that should produce warnings
on COMPILE_TEST builds when a file has a broken link.

Hopefully, this will help a lot to warn people against regressions
related to it.


Thanks,
Mauro
