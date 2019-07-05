Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08F7C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47F620863
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rvrbG2U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfGEXtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 19:49:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfGEXtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 19:49:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65Nmq8Z024441;
        Fri, 5 Jul 2019 23:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ra6Kem6NMcGrdxwE+HEeI+HohkUxPqCSf76jOp32wYQ=;
 b=rvrbG2U3eV3dzFu+UOQ+/aqMIbxSSzuaI1S2HxcZ5PeCQroTn/s1qQwVak611qZl5aso
 Skilx0Osiu24UvUkRAJdMMpo3shUoxSNcwNVOtzEY8VmZ8iTWjLLBTmKVLzdfWxyGUvI
 GDB9KtMK/M3RLRmMSgMrYjmqLtixNWgNyHDSN6BMqqphq4e98vjC3Qvr4TGUv/UakyZP
 UsCxYpxNGgPKrqulorM5EYG1eNd3Vi92cgsD5Zwv6D2e0h/qp9o64e+3CGjMO56945tL
 3EUCJk41A5j+AmpyWstdGKk5zuHgPQOR6b14vgxXqU9vm3/6qdO82gskbEbC+CIHtWQr JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2te61emryh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 23:48:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65Nlr6D161763;
        Fri, 5 Jul 2019 23:48:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2thxrvncg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 23:48:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x65NmoxQ011788;
        Fri, 5 Jul 2019 23:48:50 GMT
Received: from [10.11.0.40] (/10.11.0.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jul 2019 16:48:50 -0700
Subject: Re: [RESEND PATCH next v2 0/6] ARM: keystone: update dt and enable
 cpts support
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190705151247.30422-1-grygorii.strashko@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <2ef8b34e-7a6e-b3e4-90e0-c4e7f16c2e99@oracle.com>
Date:   Fri, 5 Jul 2019 16:48:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190705151247.30422-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050306
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/19 8:12 AM, Grygorii Strashko wrote:
> Hi Santosh,
> 
> This series is set of platform changes required to enable NETCP CPTS reference
> clock selection and final patch to enable CPTS for Keystone 66AK2E/L/HK SoCs.
> 
> Those patches were posted already [1] together with driver's changes, so this
> is re-send of DT/platform specific changes only, as driver's changes have
> been merged already.
> 
> Patches 1-5: CPTS DT nodes update for TI Keystone 2 66AK2HK/E/L SoCs.
> Patch 6: enables CPTS for TI Keystone 2 66AK2HK/E/L SoCs.
> 
> [1] https://patchwork.kernel.org/cover/10980037/
> 
> Grygorii Strashko (6):
>    ARM: dts: keystone-clocks: add input fixed clocks
>    ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
>    ARM: dts: k2e-netcp: add cpts refclk_mux node
>    ARM: dts: k2hk-netcp: add cpts refclk_mux node
>    ARM: dts: k2l-netcp: add cpts refclk_mux node
>    ARM: configs: keystone: enable cpts
> 
Will add these for 5.4 queue. Thanks !!

Regards,
Santosh
