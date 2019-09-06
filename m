Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1661C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E833207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R7bhguuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbfIFEwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 00:52:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41712 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIFEwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:52:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x864q6xo165294;
        Fri, 6 Sep 2019 04:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=KYhsWfcC1iMt71xKx7AjqLrfKI6cIO/kus0pmtMoVYI=;
 b=R7bhguuuAj+QxGbojFmU3ZneukGYN3gnkPEysNDEMgNRQ6Y46oqrb++vqLLFLdngzlA9
 WgeFLZNu1n/Ogz9q9AecZt95XQEBonCdUtzwCBb69xakojZxwpQhkdlpRVZjVt4AdEU4
 NSbnuPKrk160n7rrf+/j+R3ibkJJFVLB5CLBoh9CCNSDG2KKorEauRgR5WxCqY8NnR6w
 e3uMpod7c24GcqOfb6x9svt0w5AFkegTkNhg0zioqFPKMzW3fkiBJ+eTvE75r6j6Anui
 niRmzLwiRzhhFOi1TnQS4kL/hfrmkijyMjVj9NkAbX9n34qZaTpJC1WLJXy17/Sib57s Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2uugt5000q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 04:52:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x864mmu8128244;
        Fri, 6 Sep 2019 04:52:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2utpmc9nvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 04:52:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x864q56i010773;
        Fri, 6 Sep 2019 04:52:05 GMT
Received: from [10.159.230.78] (/10.159.230.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 21:52:04 -0700
Subject: Re: [RESEND PATCH next v2 0/6] ARM: keystone: update dt and enable
 cpts support
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190705151247.30422-1-grygorii.strashko@ti.com>
 <2ef8b34e-7a6e-b3e4-90e0-c4e7f16c2e99@oracle.com>
 <323c1835-e6b0-9153-8d1e-06200d5e2201@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <56a97316-73aa-b8ba-41f3-a374a14edc92@oracle.com>
Date:   Thu, 5 Sep 2019 21:52:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <323c1835-e6b0-9153-8d1e-06200d5e2201@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 12:33 PM, Grygorii Strashko wrote:
> Hi Santosh,
> 
> On 06/07/2019 02:48, santosh.shilimkar@oracle.com wrote:
>> On 7/5/19 8:12 AM, Grygorii Strashko wrote:
>>> Hi Santosh,
>>>
>>> This series is set of platform changes required to enable NETCP CPTS 
>>> reference
>>> clock selection and final patch to enable CPTS for Keystone 
>>> 66AK2E/L/HK SoCs.
>>>
>>> Those patches were posted already [1] together with driver's changes, 
>>> so this
>>> is re-send of DT/platform specific changes only, as driver's changes 
>>> have
>>> been merged already.
>>>
>>> Patches 1-5: CPTS DT nodes update for TI Keystone 2 66AK2HK/E/L SoCs.
>>> Patch 6: enables CPTS for TI Keystone 2 66AK2HK/E/L SoCs.
>>>
>>> [1] https://patchwork.kernel.org/cover/10980037/
>>>
>>> Grygorii Strashko (6):
>>>    ARM: dts: keystone-clocks: add input fixed clocks
>>>    ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
>>>    ARM: dts: k2e-netcp: add cpts refclk_mux node
>>>    ARM: dts: k2hk-netcp: add cpts refclk_mux node
>>>    ARM: dts: k2l-netcp: add cpts refclk_mux node
>>>    ARM: configs: keystone: enable cpts
>>>
>> Will add these for 5.4 queue. Thanks !!
> 
> Sry, that I'm disturbing you, but I do not see those patches applied?
> 
Sorry I missed this one. Will queue this up for next merge window.
Will push this out to next early once rc1 is out. If you don't
see it, please ping me.


Regards,
Santosh
