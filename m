Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1820851
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfB1WUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732272AbfB1WUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:20:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SME4ix020063
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 17:20:44 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxp0nej9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 17:20:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 28 Feb 2019 22:20:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 22:20:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SMKdkE16777366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 22:20:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 335A5A4065;
        Thu, 28 Feb 2019 22:20:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C8D1A4060;
        Thu, 28 Feb 2019 22:20:38 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 22:20:38 +0000 (GMT)
Subject: Re: [PULL REQUEST] Lock down patches
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>, jmorris@namei.org
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 28 Feb 2019 17:20:38 -0500
In-Reply-To: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022822-0008-0000-0000-000002C63AD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022822-0009-0000-0000-000022328E05
Message-Id: <1551392438.10911.227.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 13:28 -0800, Matthew Garrett wrote:
> Hi James,
> 
> David is low on cycles at the moment, so I'm taking over for this time
> round. This patchset introduces an optional kernel lockdown feature,
> intended to strengthen the boundary between UID 0 and the kernel. When
> enabled and active (by enabling the config option and passing the
> "lockdown" option on the kernel command line), various pieces of
> kernel functionality are restricted. Applications that rely on
> low-level access to either hardware or the kernel may cease working as
> a result - therefore this should not be enabled without appropriate
> evaluation beforehand.
> 
> The majority of mainstream distributions have been carrying variants
> of this patchset for many years now, so there's value in providing a
> unified upstream implementation to reduce the delta. This PR probably
> doesn't meet every distribution requirement, but gets us much closer
> to not requiring external patches.
> 
> This PR is mostly the same as the previous attempt, but with the
> following changes:

Where/when was this latest version of the patches posted?

> 
> 1) The integration between EFI secure boot and the lockdown state has
> been removed
> 2) A new CONFIG_KERNEL_LOCK_DOWN_FORCE kconfig option has been added,
> which will always enable lockdown regardless of the kernel command
> line
> 3) The integration with IMA has been dropped for now. Requiring the
> use of the IMA secure boot policy when lockdown is enabled isn't
> practical for most distributions at the moment, as there's still not a
> great deal of infrastructure for shipping packages with appropriate
> IMA signatures, and it makes it complicated for end users to manage
> custom IMA policies.

I'm all in favor of dropping the original attempt to coordinate
between the kexec PE and IMA kernel image signatures and the kernel
appended and IMA modules signatures, but there has been quite a bit of
work recently coordinating the different types of signatures.

Preventing systems which do use IMA for signature verification, should
not limit their ability to enable "lock down".  Does this version of
the "lock down" patches coordinate the different kexec kernel image
and kernel module signature verification methods? 

Mimi

