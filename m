Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211C8C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A0F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xyC1Qshs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfGLMGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:06:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47776 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:06:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3vVq093722;
        Fri, 12 Jul 2019 12:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2/cY3ZWthVr4zF3BaBmwsNFGaTKeoOtuNhP6QeMTAA4=;
 b=xyC1Qshs4IHx5WGHrLRX7cxrBMMFxGYxcQ3ts00xuizD+H2N77utRDZ8V13HlWAe8VeR
 OjUKxmzKPrO9rasrb5+x1ZywsH+/3Y9w+ONk67rxTheNr+emRuR7wvD2NfUUYQSDf5d0
 qLlehspat5zeQhLUU0hMrk+r1et2R+smHTonjgq26cruMtnSR2SLwemTra9yZG9YigbI
 u/Wv2eeVJ2N7J5TdCuR8d/dGnlMWwVgzxurtZjBWsivtUVMKP7p+Sb2YYYtSzc3DUj2x
 MH/+Jgp5rj9FeQjbljF9Aqeq5asYu3oz4xpcjagLBNlgaIi2+VWAwN5rbK7kkwtS39B7 Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tjkkq57ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:05:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CC3RVf095667;
        Fri, 12 Jul 2019 12:03:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tpefd28vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:03:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6CC3r2t020605;
        Fri, 12 Jul 2019 12:03:53 GMT
Received: from tomti.i.net-space.pl (/10.175.167.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 04:58:14 -0700
Date:   Fri, 12 Jul 2019 13:58:09 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, hpa@zytor.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v2 0/3] x86/boot: Introduce the kernel_info et consortes
Message-ID: <20190712115809.slonryrqvpbgs6xh@tomti.i.net-space.pl>
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704163612.14311-1-daniel.kiper@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=647
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=703 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 06:36:09PM +0200, Daniel Kiper wrote:
> Hi,
>
> Due to very limited space in the setup_header this patch series introduces new
> kernel_info struct which will be used to convey information from the kernel to
> the bootloader. This way the boot protocol can be extended regardless of the
> setup_header limitations. Additionally, the patch series introduces some
> convenience features like the setup_indirect struct and the
> kernel_info.setup_type_max field.

Ping?

Daniel
