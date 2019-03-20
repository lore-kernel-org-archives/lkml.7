Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB48B213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfCTMDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfCTMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:03:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KC0M8h122661
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:03:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbmaaaxrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:03:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 20 Mar 2019 12:03:30 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 12:03:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KC3Vlb40960132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 12:03:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 272DDA404D;
        Wed, 20 Mar 2019 12:03:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248ACA405F;
        Wed, 20 Mar 2019 12:03:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 12:03:30 +0000 (GMT)
Subject: Re: [PATCH v4 0/8] selftests/kexec: add kexec tests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>,
        Matthew Garrett <mjg59@google.com>, Petr Vorel <pvorel@suse.cz>
Date:   Wed, 20 Mar 2019 08:03:19 -0400
In-Reply-To: <20190320090401.GA2591@dhcp-128-65.nay.redhat.com>
References: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
         <20190318140643.GA17706@dhcp-128-65.nay.redhat.com>
         <1552932562.8658.274.camel@linux.ibm.com>
         <20190320090401.GA2591@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032012-0016-0000-0000-000002651C97
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032012-0017-0000-0000-000032C0361E
Message-Id: <1553083399.4899.236.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 17:04 +0800, Dave Young wrote:
> Hi Mimi,
> 
> Thank you for help about the pointer about IMA testing.
> Probably I should cc list as well since we are talking about the patch
> itself.  For the ima test itself I could still ask for help in a private
> email thread.

Thank you for bringing the discussion back online!

> 
> On 03/18/19 at 02:09pm, Mimi Zohar wrote:
> > On Mon, 2019-03-18 at 22:06 +0800, Dave Young wrote:
> > > Hi Mimi,
> > > 
> > > On 03/14/19 at 02:41pm, Mimi Zohar wrote:
> > > > The kernel may be configured or an IMA policy specified on the boot
> > > > command line requiring the kexec kernel image signature to be verified.
> > > > At runtime a custom IMA policy may be loaded, replacing the policy
> > > > specified on the boot command line.  In addition, the arch specific
> > > > policy rules are dynamically defined based on the secure boot mode that
> > > > may require the kernel image signature to be verified.
> > > > 
> > > > The kernel image may have a PE signature, an IMA signature, or both. In
> > > > addition, there are two kexec syscalls - kexec_load and kexec_file_load
> > > > - but only the kexec_file_load syscall can verify signatures.
> > > > 
> > > > These kexec selftests verify that only properly signed kernel images are
> > > > loaded as required, based on the kernel config, the secure boot mode,
> > > > and the IMA runtime policy.
> > > > 
> > > > Loading a kernel image or kernel module requires root privileges.  To
> > > > run just the KEXEC selftests: sudo make TARGETS=kexec kselftest
> > > > 
> > > > Changelog v4:
> > > > - Moved the kexec tests to selftests/kexec, as requested by Dave Young.
> > > > - Removed the kernel module selftest from this patch set.
> > > > - Rewritten cover letter, removing reference to kernel modules.
> > > > 
> > > > Changelog v3:
> > > > - Updated tests based on Petr's review, including the defining a common
> > > >   test to check for root privileges.
> > > > - Modified config, removing the CONFIG_KEXEC_VERIFY_SIG requirement.
> > > > - Updated the SPDX license to GPL-2.0 based on Shuah's review.
> > > > - Updated the secureboot mode test to check the SetupMode as well, based
> > > >   on David Young's review.
> > > > 
> > > > 
> > > I was trying to review the patches although I'm slow due to something
> > > else.
> > > 
> > > But I still did not setup a IMA testable system, need check your old
> > > email about how to setup it.
> > 
> > (The ima-evm-utils package contains a README with directions.)

Suggesting using the EVM README might not have been the best idea, as
we're only interested, at the moment, in enabling IMA-appraisal for
now.

You need to create 2 public keys - a local CA and an IMA key.  The
local CA public key needs to be loaded onto the builtin trusted keys
keyring.  There are a number of different methods of doing this.  The
simplest method, for those building their own kernel, is to add the
local CA public key to the certs signing_key.x509 (PEM) or to the
x509_certificate_list (DER).

Create the IMA key and then sign the IMA certificate with the local CA
key.  After rebooting the kernel with the local CA key loaded onto the
builtin trusted keyring, you'll be able to import the IMA key onto the
IMA trusted keyring.

To manually load the IMA key, without relying on dracut/systemd:

# id=`sudo keyctl describe %keyring:.ima | awk -F ':' '{print $1}';`
# evmctl import examples/x509_ima.der $id

(The evm utils package contains two sample scripts in the examples
directory to create the local CA and the IMA key.)

> > 
> > > 
> > > A quick testing gives me below results
> > > 
> > > /* test #1, my default kconfig
> > > # NO CONFIG_INTEGRITY compiled in
> > > */
> > > 
> > > make[1]: Nothing to be done for 'all'.
> > > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > TAP version 13
> > > selftests: kexec: test_kexec_load.sh
> > > ========================================
> > > selftests: kexec: test_kexec_load.sh: Warning: file
> > > test_kexec_load.sh is not executable, correct this.
> > > not ok 1..1 selftests: kexec: test_kexec_load.sh [FAIL]
> > 
> > That's really weird.  Both before and after applying these patches
> > test_kexec_load.sh is executable (stable linux-5.0.y).  Could
> > something else be preventing it from executing?
> > 
> > > selftests: kexec: test_kexec_file_load.sh
> > > ========================================
> > > [INFO] kexec_file_load is enabled
> > > [INFO] secure boot mode not enabled
> > > [INFO] kexec kernel image PE signed
> > > [INFO] kexec kernel image not IMA signed
> > > kexec_file_load succeeded (possibly missing IMA sig) [FAIL]
> > > not ok 1..2 selftests: kexec: test_kexec_file_load.sh [FAIL]
> > > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > make: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests'
> > 
> > This message is because neither CONFIG_KEXEC_BZIMAGE_VERIFY_SIG or an
> > IMA signature is required.  It couldn't read the IMA runtime policy
> > rules to determine if an IMA signature is required.  So, it's trying
> > to provide a hint as to what happened.
> > 
> > I'll update the test to see if CONFIG_IMA_APPRAISE is enabled, before
> > emitting this message.
> > 
> > > 
> > > /* test #2, enabled IMA kconfigs, simply test without other ima
> > > setup eg. use a policy etc. need to follow up some guide to test the
> > > ima functionality (TODO..)
> > > */
> > > 
> > > 
> > > [root@dhcp-128-65 linux-x86]# make -C tools/testing/selftests TARGETS=kexec run_tests
> > > make: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests'
> > > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > make[1]: Nothing to be done for 'all'.
> > > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > TAP version 13
> > > selftests: kexec: test_kexec_load.sh
> > > ========================================
> > > selftests: kexec: test_kexec_load.sh: Warning: file test_kexec_load.sh is not executable, correct this.
> > > not ok 1..1 selftests: kexec: test_kexec_load.sh [FAIL]
> > > selftests: kexec: test_kexec_file_load.sh
> > > ========================================
> > > [INFO] kexec_file_load is enabled
> > > [INFO] reading IMA policy permitted
> > > [INFO] secure boot mode not enabled
> > > No signature verification required
> > > not ok 1..2 selftests: kexec: test_kexec_file_load.sh [SKIP]
> > > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > > make: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests'
> > 
> > The purpose of these tests was to coordinate kernel image signature
> > verification.
> > 
> > If you require a PE signature, load an IMA policy requiring an IMA
> > signature, or even enable CONFIG_IMA_ARCH_POLICY, the test would
> > require some form of signature verification.
> 
> Did a test with a embedded ima key in kernel, with secure boot disabled,
> but with Secure Boot enabled, but failed to sign the kernel with both
> pesign and evmctl, will continue to see how to work on it and ask in
> private email if needed :)

"with secure boot disabled, but with Secure Boot enabled" - I'm
missing the nuance between upper and lower case "secure boot".

> 
> About the patch itself, as we talked in another email, I would expect it
> can work with other test cases eg. without IMA/secure boot.  But if that
> is not easy, maybe you can change the test script filename to something
> like:  test_kexec_load_sigcheck.sh and test_kexec_file_load_sigcheck.sh 
> then we can add other non-sigcheck related cases to other test scripts
> later.  But ideally if we can handle them in current files it would be
> better.

Ok

> Another issue I noticed is even if boot with ima_appraise=off, kexec
> load still checking the conditions. Will see if I'm having something
> wrong in test steps.

Enabling the arch policy disables the "ima_appraise=" boot command
line option.  You're right, if the arch policy isn't enabled, this
test needs to detect the "ima_appraise" mode.

Mimi

