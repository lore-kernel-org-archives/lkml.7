Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4017C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 04:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23DE208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 04:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLKEpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:45:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbfLKEpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:45:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB4gsWW047236
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 23:45:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wthkh6rpy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 23:45:50 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Wed, 11 Dec 2019 04:45:48 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Dec 2019 04:45:45 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBB4ji1i32571542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 04:45:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A93A5205F;
        Wed, 11 Dec 2019 04:45:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A48B52054;
        Wed, 11 Dec 2019 04:45:44 +0000 (GMT)
Received: from [9.81.199.13] (unknown [9.81.199.13])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8817EA0131;
        Wed, 11 Dec 2019 15:45:40 +1100 (AEDT)
Subject: Re: [ANNOUNCE] Call for Sessions - linux.conf.au 2020 Kernel Miniconf
 - Deadline Extended
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
References: <b15cd04a-b7d0-f14c-38e4-6204858425db@linux.ibm.com>
Date:   Wed, 11 Dec 2019 15:45:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b15cd04a-b7d0-f14c-38e4-6204858425db@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121104-4275-0000-0000-0000038DCF5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121104-4276-0000-0000-000038A18277
Message-Id: <488cb7d8-b42e-bc7f-0ba3-2e24cad205ad@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=912 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 6:52 pm, Andrew Donnellan wrote:
> LCA2020 Kernel Miniconf - Gold Coast, Queensland, Australia - 2020-01-14
> ------------------------------------------------------------------------
> 
> ******
> 
> LCA Kernel Miniconf submissions open!
> 
> Submissions close: 2019-12-08 (early submissions until 2019-11-17)

This deadline has been extended to 2019-12-22, but may close early once 
we have accepted enough talks.


Andrew


> 
> Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/
> 
> More info: https://lca-kernel.ozlabs.org/2020-cfs.html
> 
> ******
> 
> linux.conf.au 2020 will be held at the Gold Coast Convention and 
> Exhibition Centre, from 13-17 January 2020. The Kernel Miniconf is 
> returning once again to discuss all things kernel.
> 
> The Kernel Miniconf is a single-day miniconf track about everything 
> related to the kernel and low-level systems programming.
> 
> The Kernel Miniconf will focus on a variety of kernel-related topics - 
> technical presentations on up-and-coming kernel developments, the future 
> direction of the kernel, and kernel development community and process 
> matters. Past Kernel Miniconfs have included technical talks on topics 
> such as memory management, RCU, scheduling and filesystems, as well as 
> talks on Linux kernel community topics such as licensing and Linux 
> kernel development process.
> 
> We invite submissions on anything related to kernel and low-level 
> systems programming. We welcome submissions from developers of all 
> levels of experience in the kernel community, covering a broad range of 
> topics. The focus of the miniconf will primarily be on Linux, however 
> non-Linux talks of sufficient interest to a primarily Linux audience 
> will be considered.
> 
> Early Close Date: 2019-11-17, midnight Anywhere on Earth (UTC-12)
> Final Close Date: 2019-12-08, midnight Anywhere on Earth (UTC-12)
> Submissions: https://linux.conf.au/proposals/submit/kernel-miniconf/
> 
> ** For more information: http://lca-kernel.ozlabs.org/2020-cfs.html **
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

