Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00700C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C979420657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfCJRsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:48:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbfCJRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:48:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2AHhrv5135987
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:48:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5666a3m2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:48:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 10 Mar 2019 17:48:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Mar 2019 17:48:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2AHmlso30933050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Mar 2019 17:48:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 296604203F;
        Sun, 10 Mar 2019 17:48:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41E9A42041;
        Sun, 10 Mar 2019 17:48:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.199])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 Mar 2019 17:48:46 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 Mar 2019 13:48:33 -0400
In-Reply-To: <20190228223255.GE20335@dell5510>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
         <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
         <20190228223255.GE20335@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031017-0016-0000-0000-0000026042BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031017-0017-0000-0000-000032BADC90
Message-Id: <1552240113.5062.11.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903100138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 23:32 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > While the appended kernel module signature can be verified, when loading
> > a kernel module via either the init_module or the finit_module syscall,
> > verifying the IMA signature requires access to the file descriptor,
> > which is only available via the finit_module syscall.  As "modprobe"
> > does not provide a flag allowing the syscall - init_module or
> > finit_module - to be specified, this patch does not load a kernel
> > module.
> 
> > This test simply verifies that on secure boot enabled systems with
> > "CONFIG_IMA_ARCH_POLICY" configured, that at least an appended kernel
> > module signature or an IMA signature is required based on the Kconfig
> > and the runtime IMA policy.
> 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> ...
> > diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
> ...
> > +# Are appended signatures required?
> > +if [ -e /sys/module/module/parameters/sig_enforce ]; then
> > +	sig_enforce=$(cat /sys/module/module/parameters/sig_enforce)
> > +	if [ $sig_enforce = "Y" ]; then
> > +		log_pass "appended kernel module signature required"
> > +	fi
> > +fi
> Another possible helper [1]:
> is_enabled() # or sysfs_enabled
> {
> 	[ -f "$1" ] && [ "$(cat $1)" = "Y" -o "$(cat $1)" = "1" ]
> }
> 
> is_enabled /sys/module/module/parameters/sig_enforce && 
> 	log_pass "appended kernel module signature required"
> 

Agreed.  As this is being used only here in the IMA selftests,
deferring making this change until there is a generic common library.

Mimi


