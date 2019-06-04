Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C03424B0A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfFDNjo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:39:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbfFDNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:39:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54DWu3i093560
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 09:39:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swqamq77q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:39:41 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Tue, 4 Jun 2019 14:39:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 14:39:29 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54DdS7J50987256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 13:39:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF048AE04D;
        Tue,  4 Jun 2019 13:39:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69768AE056;
        Tue,  4 Jun 2019 13:39:27 +0000 (GMT)
Received: from [9.102.21.242] (unknown [9.102.21.242])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 13:39:27 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [POWERPC][next-20190603] Boot failure : Kernel BUG at
 mm/vmalloc.c:470
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20190604202918.17a1e466@canb.auug.org.au>
Date:   Tue, 4 Jun 2019 19:09:26 +0530
Cc:     linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
References: <9F9C0085-F8A4-4B66-802B-382119E34DF5@linux.vnet.ibm.com>
 <20190604202918.17a1e466@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 19060413-4275-0000-0000-0000033C9377
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060413-4276-0000-0000-0000384CA27D
Message-Id: <88ADCAAE-4F1A-49FE-A454-BBAB12A88C70@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 04-Jun-2019, at 3:59 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi Sachin,
> 
> On Tue, 4 Jun 2019 14:45:43 +0530 Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>> 
>> While booting linux-next [next-20190603] on a POWER9 LPAR following
>> BUG is encountered and the boot fails.
>> 
>> If I revert the following 2 patches I no longer see this BUG message
>> 
>> 07031d37b2f9 ( mm/vmalloc.c: switch to WARN_ON() and move it under unlink_va() )
>> 728e0fbf263e ( mm/vmalloc.c: get rid of one single unlink_va() when merge )
> 
> This latter patch has been fixed in today's linux-next …

Thanks Stephen. 
With today’s next (20190604) I no longer see this issue.

Thanks
-Sachin
