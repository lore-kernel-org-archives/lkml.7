Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BCBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B192146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553093378;
	bh=9Z8QThQ3+QQ8x5LMtvOgdWbwYQTlQ3aN0q0XYysjbvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PmRsR0nOv3xTUhxsaH7dM+1xM0rHSbIHEixiwPz4u7jMrgPbF8DjvJ7rM3LSWJleQ
	 QywdXYFqGaTLGSNDYewotzxWXs2m4eIZ+M+OnYQz5M5mzsH6KOAQB1vM5CLWLTCNS6
	 idjfA0iJ7tHeG3yWbypAD4Jef7MkXj/mI/nBtHj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfCTOth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfCTOtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:49:36 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DD52186A;
        Wed, 20 Mar 2019 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553093376;
        bh=9Z8QThQ3+QQ8x5LMtvOgdWbwYQTlQ3aN0q0XYysjbvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aA1bnCqdPBqk+CSF5P1qa7Ii2spNZgD5xpkF9RJtG4JhdCZwDfw3C3i7QU4NfxAWQ
         EpbTzrWysfcLcGgMp/aSYV/a/VxXKfL0MlyVew+6fjTVbeZMSgQzQymZityIIJt91a
         l8dbicpcDtJrzzJmxZoYomslBscGKb/GXr0ldlLQ=
Date:   Wed, 20 Mar 2019 22:49:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Message-ID: <20190320144907.GC8337@dragon>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
 <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320081853.GE4980@dragon>
 <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:44:18AM +0000, Andy Tang wrote:
> > > Sensor ID		placement
> > > 1			DDR controller 1
> > > 2			DDR controller 2
> > > 3			DDR controller 3
> > > 4			core cluster 1
> > > 5 		core cluster 2
> > > 6 		core cluster 3
> > > 7 		core cluster 4
> > >
> > > Apparently using CPU or CPU-cluster is not appropriate. Core-cluster is better.
> > 
> > So using CPU is appropriate for me, less confusing, more consistent with other
> > platforms.
> What about core cluster? We can't name it cpu0, cpu1 etc I think.

Hmm, yes, that would be even more confusing.  What about cpu-thermal-1,
cpu-thermal-2 ...?

Shawn
