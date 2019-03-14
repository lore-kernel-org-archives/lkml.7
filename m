Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941CC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804692077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCNSi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:38:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbfCNSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:38:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EITUEK065938
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:38:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7u1fc4d2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:38:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Mar 2019 18:38:52 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 18:38:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EIcnOb34406578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 18:38:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 508555204E;
        Thu, 14 Mar 2019 18:38:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.186])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A3BB552052;
        Thu, 14 Mar 2019 18:38:48 +0000 (GMT)
Subject: Re: [PATCH v3 5/7] selftests/ima: kexec_file_load syscall test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, Dave Young <dyoung@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 14:38:37 -0400
In-Reply-To: <20190313101436.GB25643@dell5510>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
         <1552304473-3966-6-git-send-email-zohar@linux.ibm.com>
         <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
         <1552409474.24794.63.camel@linux.ibm.com> <20190313101436.GB25643@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031418-4275-0000-0000-0000031B1041
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031418-4276-0000-0000-0000382983CB
Message-Id: <1552588717.8658.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=684 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 11:14 +0100, Petr Vorel wrote:

> > > So if split kexec tests to another folder is not doable please just
> > > ignore the comment.
> 
> > Left in the selftests/ima is a similar test for kernel modules, which
> > uses the "common" functions.  So either we wait to move the kexec
> > tests or allow them to reach into the ima directory and use the
> > ima_common_lib functions.
> I guess just load ima_common_lib.sh for now would be good enough.

After thinking about it some more, I've decided to remove the kernel
module test from this patch set and to simply move everything from the
selftests/ima to selftests/kexec.

The kernel module test will access scripts/kexec/kexec_common_lib.sh
until there is a generic set of functions.

Mimi

