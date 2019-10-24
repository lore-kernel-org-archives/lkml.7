Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB0ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DCC2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407984AbfJXKiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:38:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390754AbfJXKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:38:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OAbYtC070541
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:38:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vu75sfgg0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:38:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <hbathini@linux.ibm.com>;
        Thu, 24 Oct 2019 11:38:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Oct 2019 11:38:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9OAcAjX44761220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 10:38:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A626042047;
        Thu, 24 Oct 2019 10:38:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CC6C42045;
        Thu, 24 Oct 2019 10:38:09 +0000 (GMT)
Received: from [9.184.183.129] (unknown [9.184.183.129])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Oct 2019 10:38:09 +0000 (GMT)
Subject: Re: [PATCH] powerpc/fadump: Remove duplicate message.
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20190923075406.5854-1-msuchanek@suse.de>
 <20191023175651.24833-1-msuchanek@suse.de>
From:   Hari Bathini <hbathini@linux.ibm.com>
Date:   Thu, 24 Oct 2019 16:08:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023175651.24833-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102410-0028-0000-0000-000003AEBC69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102410-0029-0000-0000-00002470EE29
Message-Id: <aa26db2d-48b5-5825-81ab-12ca491a9971@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michal, thanks for looking into this.

On 23/10/19 11:26 PM, Michal Suchanek wrote:
> There is duplicate message about lack of support by firmware in
> fadump_reserve_mem and setup_fadump. Due to different capitalization it
> is clear that the one in setup_fadump is shown on boot. Remove the
> duplicate that is not shown.

Actually, the message in fadump_reserve_mem() is logged. fadump_reserve_mem()
executes first and sets fw_dump.fadump_enabled to `0`, if fadump is not supported.
So, the other message in setup_fadump() doesn't get logged anymore with recent
changes. The right thing to do would be to remove similar message in setup_fadump() instead.

- Hari

