Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE57C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfCZJcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:32:43 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37840 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfCZJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:32:43 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q9On53010548;
        Tue, 26 Mar 2019 04:32:39 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2rdh7jx2sx-1;
        Tue, 26 Mar 2019 04:32:39 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 49431611C8AC;
        Tue, 26 Mar 2019 04:32:39 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 09:32:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x2Q9WbJx007218;        Tue, 26 Mar 2019 09:32:37 GMT
Date:   Tue, 26 Mar 2019 09:32:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>
Subject: Re: Bad file pattern in MAINTAINERS section 'CIRRUS LOGIC LOCHNAGAR
 DRIVER'
Message-ID: <20190326093237.GH46536@ediswmail.ad.cirrus.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212455.26003-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190325212455.26003-1-joe@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:24:55PM -0700, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.
> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	3792	CIRRUS LOGIC LOCHNAGAR DRIVER
> 	3793	M:	Charles Keepax <ckeepax@opensource.cirrus.com>
> 	3794	M:	Richard Fitzgerald <rf@opensource.cirrus.com>
> 	3795	L:	patches@opensource.cirrus.com
> 	3796	S:	Supported
> -->	3797	F:	drivers/clk/clk-lochnagar.c
> 	3798	F:	drivers/mfd/lochnagar-i2c.c
> 	3799	F:	drivers/pinctrl/cirrus/pinctrl-lochnagar.c
> 	3800	F:	drivers/regulator/lochnagar-regulator.c
> 	3801	F:	sound/soc/codecs/lochnagar-sc.c
> 	3802	F:	include/dt-bindings/clk/lochnagar.h
> 	3803	F:	include/dt-bindings/pinctrl/lochnagar.h
> 	3804	F:	include/linux/mfd/lochnagar*
> 	3805	F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
> 	3806	F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
> 	3807	F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
> 	3808	F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
> 	3809	F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
> 

These files are currently in review and should hopefully be
submitted soon. They have already seen review and are just
waiting on the maintainers to get around to actually merging
them.

Thanks,
Charles
