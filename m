Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB95C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6583020854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfCYT1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:27:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729238AbfCYT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:27:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PJOANn115864
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:27:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rf3v3ue5f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:27:51 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 25 Mar 2019 19:27:49 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 19:27:46 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PJRjLP61341800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 19:27:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAD1C4C058;
        Mon, 25 Mar 2019 19:27:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D0C44C040;
        Mon, 25 Mar 2019 19:27:45 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 19:27:45 +0000 (GMT)
Subject: Re: Portable Executable (PE) Signature Validation and Measurement
 for KEXEC system call using IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Mar 2019 15:27:44 -0400
In-Reply-To: <BYAPR21MB1301CBCD4956476F8F2F0FC4C3430@BYAPR21MB1301.namprd21.prod.outlook.com>
References: <BYAPR21MB1301CBCD4956476F8F2F0FC4C3430@BYAPR21MB1301.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032519-0008-0000-0000-000002D1676A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032519-0009-0000-0000-0000223D90D7
Message-Id: <1553542064.3929.69.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

On Fri, 2019-03-22 at 17:39 +0000, Lakshmi Ramasubramanian wrote:
> Hello,
> 
> When loading the new kernel image file for executing KEXEC system call, 
> we would like to verify that the kernel image file is signed and 
> the signer certificate is valid.

I'm not sure what is meant by "and the signer certificate is valid".

The kexec kernel image signature can be verified by keys either on the
IMA keyring or the platform keyring.  The current method of verifying
keys being added to the IMA keyring is by requiring them to be signed
by a key on the builtin trusted keyring.  This provides a signature
chain of trust from boot to the kernel, based on a HW root of trust,
and then transitions to the kernel image's embedded keys.  You
probably already know as to why/how the platform keys are trusted.

> 
> If the kernel image file is in Portable Executable (PE) format we want to 
> validate the PE Signature and measure the signer X.509 certificate 
> (Extend as part of IMA Template defaulting to PCR 10, if not otherwise set, 
>  and the IMA measurement log).

How/when do you plan to "measure the signer X.509 certificate"?  Is
this when the certificate is being loaded onto the keyring or at use?
 I'm not sure how much of the certificate is available once loaded
onto the keyring.

> 
> We plan to use Integrity Measurement Architecture (IMA) for the above.
> 
> Please let us know if anyone is already working on a patch set
> for such a functionality.
> 
> I am aware of the work that Thiago Jung Bauermann @ IBM is doing for 
> "Appended signatures support for IMA appraisal" 
> (Web link given below)
> 
>     https://lkml.org/lkml/2018/12/12/1049

Other than Thiago, I'm not aware of anyone else working on this.
 Thiago is actively working on these patches and will be re-posting
them shortly.

Mimi

