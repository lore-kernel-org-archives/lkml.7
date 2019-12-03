Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3DFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8B5206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLCDn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:43:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbfLCDn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:43:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33g9pU071154
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 22:43:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6xb0j07-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:43:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Tue, 3 Dec 2019 03:43:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 03:43:20 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33hJx144564502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2019 03:43:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BD3E5204E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 03:43:19 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3CC2D5204F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 03:43:19 +0000 (GMT)
Received: from [9.81.204.28] (unknown [9.81.204.28])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 83AC5A01B6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 14:43:15 +1100 (AEDT)
Subject: Re: [ANNOUNCE] Call for Sessions - linux.conf.au 2020 Kernel Miniconf
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>
References: <b15cd04a-b7d0-f14c-38e4-6204858425db@linux.ibm.com>
Date:   Tue, 3 Dec 2019 14:43:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b15cd04a-b7d0-f14c-38e4-6204858425db@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120303-0020-0000-0000-00000392CBB0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0021-0000-0000-000021E9E9FF
Message-Id: <1ac8d366-dce1-a69a-6865-88e9e3b59e01@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=802 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030031
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

This date is coming up soon - if you've been thinking of submitting a 
talk, get on to it! :)


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

