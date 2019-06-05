Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ECDC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F73D2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFEWbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:31:25 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:37830 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfFEWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:31:25 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55MPvsO026302;
        Wed, 5 Jun 2019 22:31:05 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2sxkhks4xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 22:31:04 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 21264BA;
        Wed,  5 Jun 2019 22:31:03 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 41A0F4F;
        Wed,  5 Jun 2019 22:31:03 +0000 (UTC)
Date:   Wed, 5 Jun 2019 16:31:03 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] watchdog/hpwdt: cleanups and kdump accommodations
Message-ID: <20190605223102.GA23382@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1558126783-4877-1-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558126783-4877-1-git-send-email-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=984 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 02:59:37PM -0600, Jerry Hoemann wrote:
> First two changes makes hpwdt more generic.
> Next two changes make hpwdt work better with kdump.
> 

Hi Guenter,

Did you have feedback on this patch set?

Thanks

Jerry


> 
> Jerry Hoemann (6):
>   watchdog/hpwdt: Stop hpwdt on unregister.
>   watchdog/hpwdt: Advertize max_hw_heartbeat_ms
>   watchdog/hpwdt: Have core ping watchdog.
>   watchdog/hpwdt: Add module parameter kdumptimeout.
>   watchdog/hpwdt: Update documentation
>   watchdog/hpwdt: Reflect changes
> 
>  Documentation/watchdog/hpwdt.txt |  4 +++
>  drivers/watchdog/hpwdt.c         | 55 ++++++++++++++++++++++++++++++----------
>  2 files changed, 45 insertions(+), 14 deletions(-)
> 
> -- 
> 1.8.3.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
